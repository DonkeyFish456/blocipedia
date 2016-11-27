Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  resources :users
  resources :charges
  resources :subscribers

  get 'welcome/index'

  root 'welcome#index'
end
