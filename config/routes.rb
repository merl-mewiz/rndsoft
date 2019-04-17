Rails.application.routes.draw do
    resources :posts
    root 'posts#index'

    devise_for :users
    get 'users/profile'
    get 'users/profile', as: 'user_root'
    patch "users/profile/update", to: "users#user_update_mailing", as: "user_update_mailing"
end
