class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  # Make sure everything is only done by an authorized user
  # Fix for CanCan/Strong Parameters (expecting format ex: /api/v1/resource)
  after_action do
    resource = controller_path.singularize.gsub(/api\/v[\d]+\//i, '').gsub('/', '_')
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # Enable CanCan authorization by default
  check_authorization unless: :devise_controller?

  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence
    user = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    end
  end
end
