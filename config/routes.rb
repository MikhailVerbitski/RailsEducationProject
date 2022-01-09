Rails.application.routes.draw do
  resources :posts
  devise_for :users
  get 'persons/profile'
  root to: 'posts#index'
  get 'persons/profile', as: 'user_root'

  get 'posts/new'
  get 'posts/create'
  get 'posts/update'
  get 'posts/edit'
  get 'posts/destroy'
  get 'posts/show'
  get 'posts', to: 'posts#index'
end
