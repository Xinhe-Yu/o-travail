class QuestionsController < ApplicationController
  def index
    @questions = current_user.questions
    @question = Question.new # for form
  end
end
