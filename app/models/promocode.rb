class Promocode < ApplicationRecord
  TYPES = ['percentage', 'flat']
  validates_presence_of :name
  validates_inclusion_of :promo_type, :in => TYPES
  validates_inclusion_of :allowed_with_others, :in => [true, false]
  validate :has_percentage_or_flat_disc

  def has_percentage_or_flat_disc
    errors.add(:base, 'must add percentage or flat discount') unless self.percentage || self.flat_discount
  end
end
