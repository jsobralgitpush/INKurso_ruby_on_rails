Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sales#index'

  resource :products
  resource :clients
  
  get 'sales/new' => 'sales#new'
  post 'sales/new' => 'sales#create'

  get 'cloths/new' => 'cloths#new'
  post 'cloths/new' => 'cloths#create'
  get 'cloths/index' => 'cloths#index'
  get 'cloths/search' => 'cloths#search', :as => 'search_page_cloth'

  get 'sales/search' => 'sales#search', :as => 'search_page'
end
