class Like < ApplicationRecord
  belongs_to :user
  belongs_to :gossip

  validates :user, uniqueness: { scope: :gossip, message: " can only like once per gossip." }

  # Validator pour limiter le nombre de like qu'un utilisateur peut faire sur le même gossip
end
