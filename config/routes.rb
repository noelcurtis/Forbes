Neighborhoods::Application.routes.draw do
 
  resources :places
  resources :photos
  resources :posts
  resources :places
  resources :friendships, only: [:create, :destroy]

  devise_for :users

  root :to => redirect('/users/sign_up')

  authenticated :user do
    root to: "users#main_feed"
  end
 
  match "users/:id/add_neighborhood/:neighborhood_id" => "users#add_neighborhood", :via => :post 
  match "users/:id/main_feed"                         => "users#main_feed"
  
  resources :users do
    resources :posts
    resources :friendships, only: [:index]
  end

  match "neighborhoods/find"                                => "neighborhoods#find"
  match "neighborhoods/:id/preview"                         => "neighborhoods#preview"
  match "neighborhoods/:id/join"                            => "neighborhoods#join",          as: :join_neighborhood
  match "neighborhoods/:id/leave"                           => "neighborhoods#leave",         as: :leave_neighborhood, via: :post
  match "neighborhoods/:id/primary"                         => "neighborhoods#primary",       as: :primary_neighborhood, via: :post
  match "neighborhoods/:id/leave"                           => "neighborhoods#leave"
  match "neighborhoods/:id/select_photos"                   => "neighborhoods#select_photos"
  match "neighborhoods/:id/add_photos"                      => "neighborhoods#add_photos",    :via => :post
  match "neighborhoods/:id/add_to_favorites"                => "favorites#add_to_favorites",  :via => :post
  
  resources :neighborhoods do
    resources :posts
    resources :places do
      resources :posts
    end
  end
  
  match "neighborhoods/:neighborhood_id/places/:id/add_to_favorites" => "favorites#add_to_favorites", :via => :post
end
