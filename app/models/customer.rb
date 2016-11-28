class Customer < ApplicationRecord
  has_one :credit_card
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :credit_card
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
