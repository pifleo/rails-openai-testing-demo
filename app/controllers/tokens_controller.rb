# app/controllers/tokens_controller.rb

class TokensController < ApplicationController
  def new
    @token = Token.new
  end

  def create
    @token = Token.find_or_create_by(token: params['token']['token'])
    session[:token] = @token.token

    redirect_to conversations_url
  end
end
