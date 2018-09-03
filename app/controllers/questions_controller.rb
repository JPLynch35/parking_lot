class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at)
  end

  def show
    @question = Question.find(params[:id])
    @comments = @question.comments
  end

  def new
    return render file: '/public/404.html' unless !!current_user
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
    return render file: '/public/404.html' unless !!current_user
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private
  
  def question_params
    params.require(:question).permit(:content)
  end
end
