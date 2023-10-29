# app/models/token.rb

class Token < ApplicationRecord
  has_many :conversations
  validates :token, presence: true
end
