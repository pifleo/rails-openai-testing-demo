# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController
  def index; end

  def create
    @answer = ChatApiService.call(question)
  end

  private

  def question
    params[:question][:question]
  end
end
