Rails.application.routes.draw do
  get '/', to: 'questions#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create]
  
  resources :questions do
    resources :comments, only: [:new, :create, :edit, :update, :destroy] do
      resources :sub_comments, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  namespace :admin do
    resources :questions, only: [:show, :destroy] do
      resources :answers, only: [:create, :edit, :update, :destroy]
      resources :comments, only: [:new, :create, :edit, :update, :destroy] do
        resources :sub_comments, only: [:new, :create, :edit, :update, :destroy]
      end
    end
  end
end
