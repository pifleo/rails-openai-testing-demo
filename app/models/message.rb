# app/models/message.rb

class Message < ApplicationRecord
  belongs_to :conversation
  enum :role, %i[system user assistant], default: :user

  after_create_commit lambda {
                        broadcast_append_to 'messages', partial: 'messages/message', locals: { message: self },
                                                        target: 'messages'
                      }
  after_create :generate_ai_response

  private

  def generate_ai_response
    return if role != 'user'

    response = chat(messages: conversation.messages.map { |m| { role: m.role, content: m.content } })
    conversation.messages << Message.create(role: 'assistant', content: response)
  end

  def chat(model: 'gpt-3.5-turbo', messages: [])
    client = OpenAI::Client.new(access_token: conversation.token.token)

    response = client.chat(
      parameters: {
        model:, # Required.
        messages:, # Required.
        temperature: conversation.temperature
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end
end
