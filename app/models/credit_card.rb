class CreditCard < ApplicationRecord
  belongs_to :customer
  attr_encrypted :number, :owner_name, :key => ENV["USERKEY"]

  validates_presence_of :owner_name, :number
  validates :number, numericality: { greater_than: 0 }
end
