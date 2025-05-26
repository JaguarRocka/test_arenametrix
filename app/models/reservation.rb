class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :representation
  belongs_to :seller
  has_many :tickets, dependent: :destroy

  has_one :event, through: :representation
end
