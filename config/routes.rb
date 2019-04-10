Rails.application.routes.draw do
  devise_for :users
  get 'users/profile'
  get 'welcome/index'
  root 'welcome#index'

  get 'users/profile', as: 'user_root'
end
