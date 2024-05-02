module SessionHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    unless session[:user_id]
      flash[:error] = "Merci de vous connecter pour acceder à cette page."
      redirect_to new_session_path
    end
  end
end
