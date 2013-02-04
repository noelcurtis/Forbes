Neighborhoods::Application.routes.draw do
  resources :places
  resources :photos
  resources :posts
  resources :places

  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => redirect("/users/sign_up")
 
  match "users/:id/add_neighborhood/:neighborhood_id" => "users#add_neighborhood", :via => :post 
  match "users/:id/main_feed"                         => "users#main_feed"
  
  resources :users do
    resources :posts
  end

  match "neighborhoods/find"              => "neighborhoods#find"
  match "neighborhoods/:id/preview"       => "neighborhoods#preview"
  match "neighborhoods/:id/join"          => "neighborhoods#join" 
  match "neighborhoods/:id/select_photos" => "neighborhoods#select_photos"
  match "neighborhoods/:id/add_photos"     => "neighborhoods#add_photos",    :via => :post
  
  resources :neighborhoods do
    resources :posts
    resources :places do
      resources :posts
    end
  end
end
