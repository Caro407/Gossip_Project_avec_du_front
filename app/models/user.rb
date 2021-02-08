class User < ApplicationRecord
  belongs_to :city
  has_many :gossips
  has_many :sent_messages, foreign_key: "sender_id", class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: "recipient_id", class_name: "PrivateMessage"
  has_many :comments

  def full_name
    full_name = self.first_name + " " + self.last_name
    return full_name
  end
end
