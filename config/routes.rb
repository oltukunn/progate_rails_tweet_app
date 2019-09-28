Rails.application.routes.draw do
  root to: 'home#top'
  resources :posts
  get '/about', to:'home#about'
end
