Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  get '/stocks' => 'stocks#index'
  get '/stocks/new' => 'stocks#new'
  get '/stocks/watchlist_item' => 'stocks#watchlist_item'
end
