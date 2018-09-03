class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at)
  end

  def show
    @question = Question.find(params[:id])
    @comments = @question.comments
  end

  def new
    render file: '/public/404.html' if current_user.nil?
    @question = Question.new
  end

  def create
    @question = current_user.questions.create(question_params)
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    render file: '/public/404.html' unless (current_user == @question.user && @question.answer.nil?)
  end

  def update
    @question = Question.find(params[:id])
    render file: '/public/404.html' unless current_user == @question.user
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private
  
  def question_params
    params.require(:question).permit(:content)
  end
end
