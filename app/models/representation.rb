class Representation < ApplicationRecord
  belongs_to :event
  has_many :reservations, dependent: :destroy
  has_many :tickets, through: :reservations
  has_many :customers, through: :reservations

  validates :start_at, :end_at, :date, presence: true
end
