Rails.application.routes.draw do
  
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: "users#my_portfolio"
  get 'search_stock', to: "stocks#search"
  get 'friend_feed', to: "users#friend_feed"
  get 'search_friend', to: "users#search_friend"
end
