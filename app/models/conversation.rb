# app/models/conversation.rb

class Conversation < ApplicationRecord
  belongs_to :token
  has_many :messages, dependent: :destroy

  after_create :create_system_message

  private

  def create_system_message
    return if init_system_message.empty?

    messages.create(role: 'system', content: init_system_message)
  end
end
