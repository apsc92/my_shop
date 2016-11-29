class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private

  def current_user
    @current_user ||= login_from_session || false
  end

  def login_from_session
    if session[:customer_id]
      @customer = Customer.find_by_id(session[:customer_id])
    end
  end

  def current_order
    @current_order ||= begin
      if has_order?
        @current_order
      else
        order = Order.create(status: 'building')
        session[:order_id] = order.id
        order
      end
    end
  end

  def has_order?
    session[:order_id] && @current_order = Order.includes(:order_items).find(session[:order_id])
  end

  helper_method :current_order, :has_order?, :current_user
end
