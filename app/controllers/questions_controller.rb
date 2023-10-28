# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController
  def index; end

  def create
    @answer = AnswerQuestionService.new(question).call
  end

  private

  def question
    params[:question][:question]
  end
end
