class Tag < ApplicationRecord
  has_many :gossips_tags
  has_many :gossips, through: :gossips_tags
end
