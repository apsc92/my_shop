class CreditCard < ApplicationRecord
  belongs_to :customer
  attr_encrypted :number, :owner_name, key: :encryption_key

  validates_presence_of :owner_name, :number
  validates :number, numericality: { greater_than: 0 }


  def encryption_key
    SecureRandom.hex
  end
end
