Rails.application.routes.draw do
  root to: 'posts#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :posts do
    resources :comments, only: %i[create edit update destroy], shallow: true
    resources :votes, only: %i[create edit update destroy], shallow: true
    collection do
      get :favorites
      get :search
    end
    resources :favorites, only: %i[create destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index edit show update destroy]
    resources :boards, only: %i[index edit show update destroy]
  end
end
