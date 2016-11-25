class BundleDiscount < ApplicationRecord
  has_one :product, as: :targeted_product
end
