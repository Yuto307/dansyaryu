Rails.application.routes.draw do
  root to: 'posts#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
