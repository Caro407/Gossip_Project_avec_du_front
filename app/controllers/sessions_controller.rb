class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create_params
    params.permit(:email, :password)
  end

  def create
    # cherche s'il existe un utilisateur en base avec l’e-mail
    @user = User.find_by(email: create_params[:email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe
    if @user && @user.authenticate(create_params[:password])
      helpers.log_in(@user)
      redirect_to gossips_path
      flash[:success] = "Bienvenue #{@user.first_name} !"
    else
      flash.now[:danger] = "Invalid email/password combination"
      @user = User.new
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
