Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root to: 'pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'logout', to: 'user_sessions#destroy'
  get 'tos', to: 'pages#tos'
  get 'pp', to: 'pages#pp'
  resources :users, only: %i[new create]
  resources :posts do
    resources :comments, only: %i[create update destroy], shallow: true do
      resources :best_answers, only: %i[create destroy]
    end
    resource :closes, controller: 'posts/closes', only: %i[update]
    collection do
      get :favorites
      get :search
    end
    member do
      get :judgment
    end
  end
  resources :favorites, only: %i[create destroy]
  resources :votes, only: %i[create destroy], shallow: true
  resource :mypage, only: %i[show edit update] do
    collection do
      get :post
      get :published
      get :draft
      get :closing
      get :trash
      get :untrash
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

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
