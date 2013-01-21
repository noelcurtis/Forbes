Neighborhoods::Application.routes.draw do
  devise_for :users
  root :to => "home#main"

  resources :users
end
