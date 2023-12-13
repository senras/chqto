Rails.application.routes.draw do
  get 'about/index', to: 'about#index', as: 'about'
  get 'home/index'
  devise_for :users
  resources :links do
    member do
      get "visit_counter_chart"
      get "visit_detail"
    end
  end
  get "l/:slug" => "links#redirect_original_url", as: :redirect_original_url
  post "l/:slug" => "links#private_link_authentication", as: :private_link_authentication
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
end
