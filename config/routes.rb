Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :user_profiles, only: %i[new create edit update]
  resources :articles, only: %i[index show]
  resources :questions, only: %i[index create]
  resources :categories, only: %i[index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
end
