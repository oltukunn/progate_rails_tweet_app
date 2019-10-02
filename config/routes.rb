Rails.application.routes.draw do
  root to: 'home#top'
  resources :posts
  resources :users
  get '/about', to:'home#about'
end
