Rails.application.routes.draw do
  resources :tokens, only: [:create]
  resources :conversations do
    resources :messages, only: [:create]
  end

  resources :items
  resources :questions, only: %i[index create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root 'questions#index'
  root 'tokens#new'
end
