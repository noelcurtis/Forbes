Neighborhoods::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => "home#main"

  resources :users

  match "neighborhoods/find" => "neighborhoods#find"
  resources :neighborhoods
end
