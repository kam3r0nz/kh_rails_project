Rails.application.routes.draw do
  root 'sessions#home'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'admins/signup', to: 'admins#new'
  post 'admins/signup', to: 'admins#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  match '/auth/google_oauth2/callback', to: 'sessions#create_with_google', via: [:get, :post]
  delete 'logout', to: 'sessions#destroy'

  # get 'users/:id/animals/:id/appointments', to: 'appointments#animal_appointment_index', as: 'user_animal_appointments'

  resources :admin
  resources :animals
  resources :appointments
  resources :veterinarians, only: [:new, :create, :index]
  resources :services, only: [:new, :create, :index]

  resources :users do
    resources :animals do
      resources :appointments
    end
  end

  resources :users do
    resources :appointments
  end
end