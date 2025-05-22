class Ticket < ApplicationRecord
  belongs_to :reservation

  has_one :customer, through: :reservation
  has_one :representation, through: :reservation
  has_one :event, through: :representation
  has_one :seller, through: :reservation

  validates :number, presence: true
  validates :price, presence: true
  validates :category, presence: true
end
