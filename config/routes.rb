Rails.application.routes.draw do
  root 'companies#new'
  resources :companies do
    member do
      patch :approve
      patch :reject
    end
  end

  resources :users, only: [:new, :create, :index, :destroy, :set_password, :update_password]

  resources :users do
    member do
      get 'new_password'
      post 'create_password'
    end
  end

  get '/blank_dashboard', to: 'dashboard#blank_dashboard', as: 'blank_dashboard'

  get 'login', to: 'sessions#new', as: 'new_session'
  post 'login', to: 'sessions#create', as: 'session'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
