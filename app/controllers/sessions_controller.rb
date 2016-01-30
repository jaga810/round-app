class SessionsController < ApplicationController
  def new
  end

  def create
    circle = Circle.find_by(email: params[:session][:email].downcase)
    if circle && circle.authenticate(params[:session][:password])
      sign_in circle
      flash[:success] = "Hello #{circle.name}!"
      redirect_back_or circle
    else
      flash[:warning] = circle.blank? ? "Couldn't find such circle" : "Email or Password is not correct"
      render 'new'
    end
  end

  def googleVertification
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
