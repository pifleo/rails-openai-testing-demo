# app/controller/messages_controller.rb

class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)

    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_url(@conversation), notice: "Message was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
