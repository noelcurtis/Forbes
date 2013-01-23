Neighborhoods::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => "home#main"
 
  match "users/:id/add_neighborhood/:neighborhood_id" => "users#add_neighborhood", :via => :post 
  match "users/:id/main_feed" => "users#main_feed"
  resources :users

  match "neighborhoods/find" => "neighborhoods#find"
  match "neighborhoods/:id/preview" => "neighborhoods#preview"
  resources :neighborhoods
end
