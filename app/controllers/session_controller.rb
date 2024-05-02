
class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Bonjour #{@user.first_name} ! Vous etes connecté!" #pour afficher le bandeau alerte (Voir html new)
      redirect_to root_path, notice: 'Vous êtes connecté avec succès.'
    else
      redirect_to new_session_path, alert: 'Lun des identifiants est incorrect.'
    end
  end

  def destroy
    session.delete(:user_id)
    #session[:user_id] = nil
    flash[:danger] = "Vous etes déconnecté" #pour afficher le bandeau alerte (Voir html new)
    redirect_to root_path, notice: 'Vous avez été déconnecté avec succès.'
  end

  private 
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
