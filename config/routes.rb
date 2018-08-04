Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  resources :questions
  resources :users, only: [:new, :create]

  namespace :admin do
    resources :questions, only: [:show] do
      resources :answers, only: [:create]
    end
  end
end
