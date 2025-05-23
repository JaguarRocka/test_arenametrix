class Customer < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :tickets, through: :reservations
  has_many :representations, through: :reservations
  has_many :events, through: :representations

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A.+@.+\..+\z/, message: "is invalid" }
  validates :age, presence: true

  validates :postal_code, presence: true
  validates :country, presence: true
end
