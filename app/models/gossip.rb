class Gossip < ApplicationRecord
  belongs_to :user
  has_many :gossips_tags
  has_many :tags, through: :gossips_tags
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :users, through: :likes

  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
end
