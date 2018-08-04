class Admin::QuestionsController < Admin::BaseController
  def show
    @question = Question.includes(:answer).find(params[:id])
    @answer = Answer.new
  end
end
