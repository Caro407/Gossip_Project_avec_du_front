class User < ApplicationRecord
  belongs_to :city
  has_secure_password
  has_many :gossips
  has_many :sent_messages, foreign_key: "sender_id", class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: "recipient_id", class_name: "PrivateMessage"
  has_many :comments
  has_many :likes
  has_many :gossips, through: :likes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, length: { maximum: 200 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def full_name
    full_name = self.first_name + " " + self.last_name
    return full_name
  end

  def has_already_liked?(gossip)
    return true if self.likes.where(gossip_id: gossip.id).count > 0
  end

  def find_like(gossip)
    self.likes.find_by(gossip_id: gossip.id)
  end
end
