Rails.application.routes.draw do
  root 'companies#new'
  resources :companies do
    member do
      patch :approve
      patch :reject
    end
  end
  resources :documents, only: [:new, :create, :index, :show, :destroy]
  resources :users, only: [:new, :create, :index, :destroy]

  get 'login', to: 'sessions#new', as: 'new_session'
  post 'login', to: 'sessions#create', as: 'session'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
