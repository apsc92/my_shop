class Promocode < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :has_percentage_or_flat_disc

  def has_percentage_or_flat_disc
    errors.add(:base, 'must add percentage or flat discount') unless self.percentage || self.flat_discount
  end
end
