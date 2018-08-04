class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.create(question_params)
    if @question.save
      redirect_to question_path(@question)
    else
      :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      :edit
    end
  end

  private
  
  def question_params
    params.require(:question).permit(:content)
  end
end
