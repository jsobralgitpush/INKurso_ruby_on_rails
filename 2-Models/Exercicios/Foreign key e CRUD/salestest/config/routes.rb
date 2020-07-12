Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sales#index'

  resource :products
  resource :clients
  
  get 'sales/new' => 'sales#new'
  post 'sales/new' => 'sales#create'
end
