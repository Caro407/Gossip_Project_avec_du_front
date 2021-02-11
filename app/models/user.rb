class User < ApplicationRecord
  belongs_to :city
  has_secure_password
  has_many :gossips
  has_many :sent_messages, foreign_key: "sender_id", class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: "recipient_id", class_name: "PrivateMessage"
  has_many :comments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, length: { maximum: 200 }
  validates :email, presence: true, uniqueness: true

  def full_name
    full_name = self.first_name + " " + self.last_name
    return full_name
  end
end
