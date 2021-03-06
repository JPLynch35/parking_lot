class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to questions_path
    else
      render :new
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
