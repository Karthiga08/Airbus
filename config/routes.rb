Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bookings do
    member do
      get :booking_successfull
    end
  end

  root to: 'bookings#index'
  resources :planes
end
