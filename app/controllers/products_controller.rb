class ProductsController < ApplicationController

  def index
    @products = Product.all.order(name: :asc)
  end
end
