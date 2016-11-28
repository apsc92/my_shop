Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :products, only: [:index, :show] do
    member do
      post 'buy'
    end
  end

  resources :orders, only: [:show]
  resources :order_items, only: [:destroy, :update]
  match 'checkout' => 'orders#checkout', :as => 'checkout', via: [:get, :patch]
  match 'apply_promocode' => 'orders#apply_promocode', via: [:post]
  delete 'remove_promocode/:promocode_id' => 'orders#remove_promocode', :as => 'remove_promocode'
  post 'confirm_order' => 'orders#confirm_order'
end
