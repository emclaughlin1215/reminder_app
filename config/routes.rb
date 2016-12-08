Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :user do
    resources :tasks
  end

  namespace :api do
    namespace :v1  do
      resources :tokens, :only => [:create, :destroy]
    end
  end
end
