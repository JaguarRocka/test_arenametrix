class Seller < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
