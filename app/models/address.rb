class Address < ApplicationRecord
  belongs_to :order
  validates_presence_of :street_address, :city, :state
end
