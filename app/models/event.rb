class Event < ApplicationRecord
  has_many :representations, dependent: :destroy
  has_many :reservations, through: :representations
  has_many :tickets, through: :reservations
  has_many :customers, through: :reservations

  validates :name, presence: true

  # problème ici si y a des homonymes
end
