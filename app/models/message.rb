# app/models/message.rb

class Message < ApplicationRecord
  belongs_to :conversation
  enum :role, %i[system user assistant], default: :user

  before_save { self.content.strip unless self.content.nil? }
  after_create_commit lambda {
                        broadcast_append_to 'messages', partial: 'messages/message', locals: { message: self },
                                                        target: 'messages'
                      }
  after_create :generate_ai_response

  private

  def generate_ai_response
    return if role != 'user'

    messages = conversation.messages.map { |m| { role: m.role, content: m.content } }
    response, usage = chat(messages:)

    conversation.messages << Message.create(role: 'assistant', content: response, usage:)
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

    [response.dig('choices', 0, 'message', 'content'), response.dig('usage')]
  end
end
