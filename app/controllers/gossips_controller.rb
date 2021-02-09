class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
  end

  def index
  end

  def new
    @gossip = Gossip.new
  end

  def create
    pp params
    #1ère étape : récupérer les params et vérifier que tout roule
    user = User.find_by(first_name: params[:user])

    if user == nil
      render :new
      return
    end

    #2ème étape : on prépare la nouvelle instance
    @gossip = Gossip.new(user_id: user.id, content: params[:content], title: params[:title])

    #3ème étape : save and redirect
    if @gossip.save
      redirect_to gossips_path
    else
      render :new
      return
    end
  end
end
