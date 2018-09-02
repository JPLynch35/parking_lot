Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  resources :questions do
    resources :comments, only: [:new]
  end

  resources :users, only: [:new, :create]

  namespace :admin do
    resources :questions, only: [:show, :destroy] do
      resources :answers, only: [:create, :edit, :update, :destroy]
    end
  end
end
