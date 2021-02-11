class LikesController < ApplicationController
  before_action :get_like_params

  def like_params
    params.permit(:gossip_id, :id)
  end

  def create
    @like = Like.new(user: @user, gossip: @gossip)
    pp @like

    if @like.save
      redirect_back(fallback_location: root_path)
    else
      redirect_to gossip_path(@gossip.id)
      flash[:warning] = "Echec : " + @like.errors.full_messages.join(" ")
    end
  end

  # SUPPRIMER UN LIKE

  def destroy
    @like = Like.find(like_params[:id])

    @like.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def get_like_params
    @gossip = Gossip.find(like_params[:gossip_id])
    @user = helpers.current_user
  end
end
