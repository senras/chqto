Rails.application.routes.draw do
  get 'about/index', to: 'about#index', as: 'about'
  get 'home/index'
  devise_for :users
  resources :links
  get "l/:slug" => "links#send_to_original_url", as: :send_to_original_url
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
