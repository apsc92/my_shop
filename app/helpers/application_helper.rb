module ApplicationHelper
  def show_in_currency(price)
    number_to_currency price, { :unit => "£"}
  end
end
