class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, :only => [:create, :new]
  skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  # Only do this if it's a JSON request. HTML can use the devise one.
  respond_to :json

  def new
    user = User.new(sign_in_params)
    clean_up_passwords(user)
    respond_with(user, serialize_options(user))
  end

  def create
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        user = user_from_credentials
        return invalid_login_attempt unless user

        if user.valid_password?(params[:password])
          render :json => { user: { email: user.email, :auth_token => user.authentication_token } }, success: true, status: :created
        else
          invalid_login_attempt
        end
      }
    end
  end

  def destroy
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        user = User.find_by_authentication_token(request.headers['X-API-TOKEN'])
        if user
          user.reset_authentication_token!
          render :json => { :message => 'Session deleted.' }, :success => true, :status => 204
        else
          render :json => { :message => 'Invalid token.' }, :status => 401
        end
      }
    end
  end

  protected
    def invalid_login_attempt
      warden.custom_failure!
      render json: { success: false, message: 'Error with your login or password' }, status: 401
    end

    def user_from_credentials
      data = { email: params[:email] }
      if res = User.find_for_database_authentication(data)
        if res.valid_password?(params[:password])
          res
        end
      end
    end
end