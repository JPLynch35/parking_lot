class Admin::AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.create(answer_params_question_id)
    redirect_to admin_question_path(@question)
  end

  def edit
    @question = Question.includes(:answer).find(params[:question_id])
    @answer = @question.answer
  end

  def update
    @question = Question.includes(:answer).find(params[:question_id])
    @answer = @question.answer
    if @answer.update(answer_params_question_id)
      redirect_to admin_question_path(@question)
    else
      render :edit
    end
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
