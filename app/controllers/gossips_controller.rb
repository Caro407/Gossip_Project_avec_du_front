class GossipsController < ApplicationController
  before_action :check_user_logged_in, except: [:show, :index]
  before_action :check_user_is_author, only: [:edit, :update, :destroy]

  def show
    @gossip = Gossip.find(params[:id])
    @city = City.find(@gossip.user.city_id).name
  end

  def index
  end

  # CREER UN NOUVEAU POTIN

  def new
    @gossip = Gossip.new
  end

  def create_params
    params.permit(:content, :title)
  end

  def create
    #1ère étape : récupérer les params
    user = helpers.current_user

    #2ème étape : on prépare la nouvelle instance
    @gossip = Gossip.new(user: user, content: create_params[:content], title: create_params[:title])

    #2ème étape bis: on vérifie que tout roule
    if user == nil
      flash[:warning] = "Echec lors de la création du potin : merci de recommencer."
      render :new
      return
    end

    #3ème étape : save and redirect
    if @gossip.save
      redirect_to gossips_path
      flash[:success] = "Potin créé !"
    else
      flash[:warning] = "Echec : " + @gossip.errors.full_messages.join(" ")
      render :new
      return
    end
  end

  # EDITER UN POTIN EXISTANT

  def edit_params
    params.permit(:id)
  end

  def edit
    @gossip = Gossip.find(edit_params[:id])
  end

  def update_params
    params.require(:gossip).permit(:title, :content)
  end

  def update
    #1ère étape : récupérer les params
    @gossip = Gossip.find(params[:id])

    #2ème étape : on prépare la nouvelle instance
    @gossip.title = update_params[:title]
    @gossip.content = update_params[:content]

    #3ème étape : save and redirect
    if @gossip.save
      redirect_to gossips_path(params[:id])
      flash[:success] = "Potin mis à jour !"
    else
      flash[:warning] = "Echec : " + @gossip.errors.full_messages.join(" ")
      render :edit
    end
  end

  # SUPPRIMER UN POTIN
  def destroy_params
    params.permit(:id)
  end

  def destroy
    @gossip = Gossip.find(destroy_params[:id])

    @gossip.destroy

    redirect_to gossips_path
  end

  private

  def check_user_logged_in
    if helpers.logged_in? == false
      redirect_to new_session_path
      flash[:warning] = "Tu dois d'abord te connecter."
      return
    end
  end

  def check_user_is_author
    if helpers.current_user != Gossip.find(params[:id]).user
      redirect_to gossip_path(params[:id])
      flash[:warning] = "Tu n'es pas l'auteur de ce potin : tu ne peux donc pas le modifier."
      return
    end
  end
end
