Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks do
    collection do
      patch ':id/finish', to: "tasks#finish"
    end
  end
  resources :users
  resources :login, only: [:index, :create] do
    collection do
      delete  '/', to: "login#delete"
    end
  end
end
