class Customer < ApplicationRecord
  has_many :credit_cards
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :credit_cards
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
