class Representation < ApplicationRecord

  belongs_to :event
  has_many :reservations, dependent: :destroy
  has_many :tickets, through: :reservations
  has_many :clients, through: :reservations

  validates :starts_at, :ends_at, :date, presence: true

end
