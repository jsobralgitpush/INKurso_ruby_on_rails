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
  get 'cloths/index/:page' => 'cloths#index', :as => 'cloth_page' 
  get 'cloths/search' => 'cloths#search', :as => 'search_page_cloth'
  get 'cloths/filter(/:gender)(/:tipo)(/:price)' => 'cloths#filter', :as => 'filter_id_cloth'
  get 'cloths/:item' => 'cloths#item', :as => 'cloth_item'
  get 'cloths/:item/:color' => 'cloths#item_color', :as => 'cloth_color'

  #Rotas para favoritos
  get 'favorite(/:id)' => 'cloths#favorites', :as => 'cloth_favorite'
  get 'unfavorite(/:id)' => 'cloths#unfavorite', :as => 'cloth_unfavorite'


  #Rota de lojista
  get 'artist/:market' => 'cloths#market', :as => 'cloth_market'
  get 'artist/:market/about' => 'cloths#about', :as => 'cloth_about'

  get 'stocks/new' => 'stocks#new'
  post 'stocks/new' => 'stocks#create'


  post 'stocks/discount/:cloth_id/:cor' => 'stocks#discount', :as => 'cloth_discount' 

  get 'sales/search' => 'sales#search', :as => 'search_page'
end


