class ChatService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    messages = training_prompts.map do |prompt|
      { role: 'system', content: prompt }
    end

    messages << { role: 'user', content: message }

    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages:,
        temperature: 0.7
      }
    )

    response.dig('choices', 0, 'message', 'content')
  end

  private

  def training_prompts
    [
      'Do you know who captain jean luc picard is? Just tell me yes or no',
      'Can you pretend to be captain jean luc picard from here on out? Answer yes or no'
    ]
  end

  def client
    @_client ||= OpenAI::Client.new
  end
end

# ChatService.new(message: "the borg are coming to attack, what should we do captain?").call
# Inspired from: https://rapidruby.com/lessons/54-chat-gpt-basics-with-ruby-on-rails
