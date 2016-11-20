Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  resources :users

  get 'welcome/index'

  root 'welcome#index'
end
