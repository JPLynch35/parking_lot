class CommentsController < ApplicationController
  def new
    return render file: '/public/404.html' unless !!current_user
    @question = Question.find(params[:question_id])
    @comment = Comment.new
    @comment.question_id = @question.id
  end

  def create
    @question = Question.find(params[:question_id])
    @comment = current_user.comments.create(full_comment_params)
    if @comment.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def edit
    return render file: '/public/404.html' unless !!current_user
    @question = Question.find(params[:question_id])
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @comment = current_user.comments.find(params[:id])
    if @comment.update(full_comment_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to question_path(@question)
  end

  private

  def partial_comment_params
    params.require(:comment).permit(:content, :question_id)
  end
  
  def full_comment_params
    full_params = partial_comment_params
    full_params[:question_id] = @question.id
    full_params
  end
end
