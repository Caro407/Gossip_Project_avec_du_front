class Gossip < ApplicationRecord
  belongs_to :user
  has_many :gossips_tags
  has_many :tags, through: :gossips_tags
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
end
