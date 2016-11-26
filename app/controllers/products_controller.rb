class ProductsController < ApplicationController

  def index
    @products = Product.all.order(name: :asc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def buy
    @product = Product.find(params[:id])
    current_order.add_item(@product, params[:quantity].blank? ? 1 : params[:quantity].to_i)
    redirect_to root_path, notice: 'Item added to your cart successfully'
  end
end
