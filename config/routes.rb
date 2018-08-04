Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :questions, only: [:index, :show, :new, :create]
  resources :users, only: [:new, :create]
end
