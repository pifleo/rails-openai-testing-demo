json.extract! conversation, :id, :temperature, :init_system_message, :model, :token_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
