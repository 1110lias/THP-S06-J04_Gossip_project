class UserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts "**********************************************************************************************winner"
    puts @user
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Bienvenue ! Votre compte a été créé avec succès."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :age, :first_name, :last_name, :city_id)
  end
end
