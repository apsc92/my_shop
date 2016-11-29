Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :products, only: [:index, :show] do
    member do
      post 'buy'
    end
  end

  resources :customers, only: [:new, :create] do
    resources :credit_cards, only: [:new, :create]
  end

  resources :orders, only: [:show, :edit] do
    resources :addresses, only: [:new, :create]
  end

  resources :order_items, only: [:destroy, :update]
  match 'apply_promocode/:id' => 'orders#apply_promocode', via: [:post], :as => 'apply_promocode'
  put 'remove_promocode/:promocode_id' => 'orders#remove_promocode', :as => 'remove_promocode'
end
