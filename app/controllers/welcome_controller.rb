class WelcomeController < ApplicationController
  def index
    redirect_to questions_path
  end
end
