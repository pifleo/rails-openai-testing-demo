# app/controller/application_controller.rb

class ApplicationController < ActionController::Base
  def authorize!
    if session[:token]
      @token = Token.find_by(token: session[:token])
    else
      redirect_to root_url
    end
  end
end
