module SessionsHelper

  def sign_in(circle)
    remember_token = Circle.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    circle.update_attribute(:remember_token, Circle.encrypt(remember_token))
    self.current_circle = circle
  end

  def current_circle=(circle)
    @current_circle = circle
  end

  def current_circle
    remember_token = Circle.encrypt(cookies[:remember_token])
    @current_circle ||= Circle.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_circle.nil?
  end

  def sign_out
    self.current_circle = nil
    cookies.delete(:remember_token)
  end

  def signed_in_circle
    unless signed_in?
      store_location
      flash[:success]= "please sign in"
      redirect_to signin_url
    end
  end

  def current_circle?(circle)
    circle == current_circle
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to]||default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
