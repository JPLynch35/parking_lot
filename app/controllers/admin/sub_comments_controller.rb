class Admin::SubCommentsController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @comment = Comment.find(params[:comment_id])
    @sub_comment = SubComment.new
    @sub_comment.comment_id = @comment.id
  end

  def create
    question = Question.find(params[:question_id])
    @comment = Comment.find(params[:comment_id])
    @sub_comment = current_user.sub_comments.create(full_sub_comment_params)
    if @sub_comment.save
      redirect_to admin_question_path(question)
    else
      render :new
    end
  end

  def edit
    return render file: '/public/404.html' unless !!current_user
    @question = Question.find(params[:question_id])
    @comment = Comment.find(params[:comment_id])
    @sub_comment = current_user.sub_comments.find(params[:id])
  end

  def update
    question = Question.find(params[:question_id])
    @comment = question.comments.find(params[:comment_id])
    @sub_comment = current_user.sub_comments.find(params[:id])
    if @sub_comment.update(full_sub_comment_params)
      redirect_to admin_question_path(question)
    else
      render :edit
    end
  end

  def destroy
    question = Question.find(params[:question_id])
    comment = question.comments.find(params[:comment_id])
    @sub_comment = comment.sub_comments.find(params[:id])
    @sub_comment.destroy
    redirect_to admin_question_path(question)
  end

  private

  def partial_sub_comment_params
    params.require(:sub_comment).permit(:content)
  end
  
  def full_sub_comment_params
    full_params = partial_sub_comment_params
    full_params[:comment_id] = @comment.id
    full_params
  end
end
