Rails.application.routes.draw do
  devise_for :users
  root to: 'home#top'
  get '/test', to: 'home#test'
  resources :tasks, only: [:index]
end
