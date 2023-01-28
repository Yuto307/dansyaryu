Rails.application.routes.draw do
  root to: 'posts#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  resources :users, only: %i[new create]
  resources :posts do
    resources :comments, only: %i[create edit update destroy], shallow: true do
      resources :best_answers, only: %i[create destroy]
    end
    resources :votes, only: %i[create edit update destroy], shallow: true
    resource :closes, controller: 'posts/closes', only: %i[update]
    collection do
      get :favorites
      get :search
    end
    member do
      get :judgment
    end
    resources :favorites, only: %i[create destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :mypage do
    root 'profile#show'
    resource :profile, only: %i[show update]
    resource :password_change, only: %i[show update]
  end

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    get 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index edit show update destroy]
    resources :posts, only: %i[index edit show update destroy]
    resources :categories, only: %i[new create index edit show update destroy]
  end
end
