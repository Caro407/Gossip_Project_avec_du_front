class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
  end

  def index
  end

  def new
    @gossip = Gossip.new
  end

  def create_params
    params.permit(:user, :content, :title)
  end

  def create
    pp params
    #1ère étape : récupérer les params
    user = User.find_by(first_name: create_params[:user])

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
end
