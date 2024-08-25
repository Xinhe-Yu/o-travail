require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  def index
    @questions = current_user.questions
    @question = Question.new # for form
  end
end
