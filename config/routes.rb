Rails.application.routes.draw do
  get 'pages/home'
  get 'sessions/new'
  get 'reservations/new'
  get 'reservations/index'
  get 'reservations/show'
  get 'rooms/new'
  get 'rooms/index'
  get 'rooms/search'
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
