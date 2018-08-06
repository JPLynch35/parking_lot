class Admin::AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.create(answer_params_question_id)
    redirect_to admin_question_path(@question)
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to questions_path
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def answer_params_question_id
    data_set = answer_params
    data_set[:question_id] = @question.id
    data_set
  end
end
