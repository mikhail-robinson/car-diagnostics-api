Rails.application.routes.draw do
  namespace :api do
    resources :cars do
      resources :service_history_entries, only: [:index, :create]
    end
    resources :service_history_entries, only: [:show, :index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
