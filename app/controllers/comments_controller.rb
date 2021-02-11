class CommentsController < ApplicationController
  before_action :get_gossip

  def index
    @comments = @gossip.comments
  end

  def new
    @comments = @gossip.comments.build
  end

  def create_params
    params.permit(:gossip_id, :content)
  end

  def create
    #1ère étape : récupérer les params
    user = helpers.current_user

    #2ème étape : on prépare la nouvelle instance
    @comments = @gossip.comments.build(user: user, content: create_params[:content], gossip: @gossip)

    #2ème étape bis: on vérifie que tout roule
    if user == nil
      flash[:warning] = "Echec lors de la création du potin : merci de recommencer."
      render :new
      return
    end

    #3ème étape : save and redirect
    if @comments.save
      redirect_to gossip_path(create_params[:gossip_id])
      flash[:success] = "Commentaire créé !"
    else
      flash[:warning] = "Echec : " + @comments.errors.full_messages.join(" ")
      render :new
      return
    end
  end

  private

  def get_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
end
