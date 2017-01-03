require 'api_constraints'

Rails.application.routes.draw do
  # Need this here to get the helpers working
  devise_for :user

  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      # Need this here to make the user routes be in the right place
      devise_for :users
      # To do subroutes for each user
      resources :user do
        resources :tasks
      end
    end
  end
end
