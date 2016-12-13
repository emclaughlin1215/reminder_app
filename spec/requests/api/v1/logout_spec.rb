require 'rails_helper'

describe "Logout API" do
  it "allows logout with auth token" do
    user = FactoryGirl.create(:user)

    login_data = { :email => user.email, :password => user.password }

    post '/api/v1/users/sign_in.json', params: login_data
    auth_token = json['user']['auth_token']

    delete '/api/v1/users/sign_out.json', headers: { 'X-API-TOKEN' => auth_token }

    # TODO: Add something here that checks if an action requiring authorization
    # returns a 403.
  end

  it "doesn't allow logout without auth token" do
    user = FactoryGirl.create(:user)

    login_data = { :email => user.email, :password => user.password }

    post '/api/v1/users/sign_in.json', params: login_data
    auth_token = 'asfd987jhiofadoih'

    delete '/api/v1/users/sign_out.json', headers: { 'X-API-TOKEN' => auth_token }

    # TODO: Add something here that checks if an action requiring authorization
    # returns a 200.
  end
end