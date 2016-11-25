class Product < ApplicationRecord
  validates_presence_of :price, :name
  validates :price, numericality: { greater_than: 0 }
end
