Rails.application.routes.draw do
  get 'tasks/index'
  devise_for :users
  root to: 'home#top'
  get '/test', to: 'home#test'
end
