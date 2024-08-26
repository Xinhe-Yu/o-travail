class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: questions_formatted_for_openai # to code as private method
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    question.update(ai_answer: new_content)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: question })
  end

  def get_nearest_articles
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )
    question_embedding = response['data'][0]['embedding']
    nearest_articles = Article.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    ).first(5)
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def user_profile
    profile = []
    profile << @question.user.profession_level
    profile << @question.user.experience_level
    profile.empty? ? "qui ont #{profile.join(" et ")}" : ""
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []

    system_text = "Vous êtes un assistant virtuel spécialisé dans le Code du travail français. Votre rôle est d'aider les utilisateurs #{user_profile} à naviguer dans les articles du Code du travail, à comprendre leurs droits et obligations, et à répondre à leurs questions de manière claire et précise. Lorsque vous fournissez des réponses, veillez à citer les articles pertinents du Code du travail en utilisant un langage #{@question.user.terminology_preference}. Si l'utilisateur n'est pas certain des termes qu'il doit utiliser, aidez-le à affiner sa recherche en posant des questions supplémentaires ou en suggérant des mots-clés. Soyez toujours courtois, patient, et orienté vers la solution."
    nearest_articles = get_nearest_articles
    nearest_articles.each do |article|
      system_text += "** ARTICLE #{article.art_num} : texte : #{article.text} **"
    end

    results << { role: "system", content: system_text }
    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end

    return results
  end
end
