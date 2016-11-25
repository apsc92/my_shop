class CreditCard < ApplicationRecord
  belongs_to :customer

  validates_presence_of :owner_name, :number
  validates :number, numericality: { greater_than: 0 }
end
