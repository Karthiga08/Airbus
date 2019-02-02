Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bookings do
    member do
      get :booking_successfull
    end
  end

  root to: 'planes#index'
  resources :planes

  post '/cancel_seats' => 'bookings#cancel_seats', as: :cancel_seats
  get '/seat_vacancies' => 'planes#seat_vacancies', as: :seat_vacancies
  post '/upgrade_seats' => 'bookings#upgrade_seats', as: :upgrade_seats
end
