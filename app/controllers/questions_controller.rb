class QuestionsController < ApplicationController
  def index
    @questions = Question.order(:created_at)
  end
end
