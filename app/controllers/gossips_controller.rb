class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
  end

  def index
  end
end
