class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @cities = City.order(:name)
  end

  def create_params
    params.permit(:first_name, :last_name, :email, :city, :password, :password_confirmation)
  end

  def create
    #1ère étape : on prépare la nouvelle instance
    @user = User.new(first_name: create_params[:first_name],
                     last_name: create_params[:last_name],
                     email: create_params[:email],
                     city_id: create_params[:city],
                     password: create_params[:password],
                     password_confirmation: create_params[:password_confirmation])

    #2ème étape : save and redirect
    if @user.save
      redirect_to gossips_path
      flash[:success] = "Bienvenue #{@user.first_name} !"
    else
      flash[:warning] = "Echec : " + @user.errors.full_messages.join(" ")
      @cities = City.order(:name)
      render :new
      return
    end
  end
end
