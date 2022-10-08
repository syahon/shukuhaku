Rails.application.routes.draw do
  root 'pages#home'
  get '/login',    to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/sign_up',  to: 'users#new'
  resources :users, only: [:show, :edit, :create, :update, :destroy]
  resources :reservations, only: [:new, :index, :create]
  resources :rooms, only: [:new, :index, :show, :create] do
    collection do
      get :search
    end
  end
end
