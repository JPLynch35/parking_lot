class Admin::QuestionsController < Admin::BaseController
  def show
    @question = Question.includes(:answer).find(params[:id])
    @answer = Answer.new
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to questions_path
    else
      redirect_to admin_question_path(@question)
    end
  end
end
