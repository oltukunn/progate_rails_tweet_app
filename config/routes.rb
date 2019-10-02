Rails.application.routes.draw do
  root to: 'home#top'
  resources :posts
  resources :users
  get '/login', to:'users#login_form'
  post '/login', to:'users#login'
  post '/logout', to:'users#logout'
  get '/about', to:'home#about'
end
