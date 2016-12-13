Rails.application.routes.draw do
  # Need this here to get the helpers working
  devise_for :user

  namespace :api do
    namespace :v1  do
      # Need this here to make the user routes be in the right place
      devise_for :users
      # To do subroutes for each user
      resources :user do
        resources :tasks
      end
    end
  end
end
