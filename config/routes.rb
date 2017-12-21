Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks
  namespace 'tasks' do
    patch ':id/finish', to: "finish#update"
  end
  resources :users
  resources :sessions, only: [:index, :create] do
    collection do
      delete  '/', to: "sessions#delete"
    end
  end
end
