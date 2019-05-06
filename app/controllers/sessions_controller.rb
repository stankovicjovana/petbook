class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user.try(:authenticate, params[:password])
  		session[:user_id] = user.id
  		redirect_to user_url(user.id)
  	else
  		redirect_to login_url, alert: "Invalid email/password combination"
  	end
  end

  def destroy

  end
end
