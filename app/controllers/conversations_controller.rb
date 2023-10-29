# app/controller/conversations_controller.rb

class ConversationsController < ApplicationController
  before_action :authorize!

  def index
    @conversations = @token.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.token = @token

    return unless @conversation.save!

    redirect_to conversation_url(@conversation)
  end

  private

  def conversation_params
    params.fetch(:conversation, {}).permit(:temperature, :init_system_message)
  end
end
