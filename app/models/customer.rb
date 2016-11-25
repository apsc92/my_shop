class Customer < ApplicationRecord
  has_many :credit_cards
  has_many :orders, dependent: :destroy
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
