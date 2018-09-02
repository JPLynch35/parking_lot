class CommentsController < ApplicationController
  def new
    render file: '/public/404.html' if current_user.nil?
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
      :new
    end
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
