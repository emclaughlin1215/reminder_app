class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Make sure everything is only done by an authorized user
  check_authorization
end
