Rails.application.routes.draw do
  devise_for :users

  resources :wikis

  get 'welcome/index'

  root 'welcome#index'
end
