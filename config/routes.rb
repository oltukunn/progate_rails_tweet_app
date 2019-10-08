Rails.application.routes.draw do
  root to: 'home#top'
  resources :posts
  resources :users
  get '/login', to:'users#login_form'
  post '/login', to:'users#login'
  post '/logout', to:'users#logout'
  get '/about', to:'home#about'
  post '/likes/:post_id/create', to:'likes#create'
  post '/likes/:post_id/destroy', to:'likes#destroy'
  get 'users/:id/likes',to:'users#likes'
end
