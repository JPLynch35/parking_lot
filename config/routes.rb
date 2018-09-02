Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  
  get '/questions', to: 'questions#index'
  get '/questions/new', to: 'questions#new', as: 'new_question'
  post '/questions', to: 'questions#create'
  get '/questions/:id', to: 'questions#show', as: 'question'
  get '/questions/:id/edit', to: 'questions#edit', as: 'edit_question'
  patch '/questions/:id', to: 'questions#update'
  delete '/questions/:id', to: 'questions#destroy'
  # resources :questions

  get '/users/new', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'
  # resources :users, only: [:new, :create]

  get '/admin/questions/:id', to: 'admin/questions#show', as: 'admin_question'
  delete '/admin/questions/:id', to: 'admin/questions#destroy'

  post '/admin/questions/:question_id/answers', to: 'admin/answers#create', as: 'admin_question_answers'
  get '/admin/questions/:question_id/answers/:id', to: 'admin/answers#show', as: 'admin_question_answer'
  delete '/admin/questions/:question_id/answers/:id', to: 'admin/answers#destroy'
  get '/admin/questions/:question_id/answers/:id/edit', to: 'admin/answers#edit', as: 'edit_admin_question_answer'
  patch '/admin/questions/:question_id/answers/:id', to: 'admin/answers#update'
  # namespace :admin do
  #   resources :questions, only: [] do
  #     resources :answers, only: [:create, :edit, :update, :destroy]
  #   end
  # end
end
