require 'rails_helper'

describe "Login API" do
  it 'allows login with good credentials' do
    user = FactoryGirl.create(:user)

    login_data = { :email => user.email, :password => user.password }

    post '/api/v1/users/sign_in.json', params: login_data

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of values were returned
    expect(json.length).to eq 1

    expect(json['user'].length).to eq 2
    # check to make sure that one value was the correct email address
    expect(json['user']['email']).to eq user.email
    # check to make sure that one value is the access token
    expect(json['user']['auth_token']).not_to eq(nil)
    expect(json['user']['auth_token'].length).to be > 0
  end

  it 'does not allow login with bad credentials' do
    user = FactoryGirl.create(:user)

    login_data_none = { :email => '', :password => '' }
    login_data_no_email = { :email => '', :password => user.password}
    login_data_no_pass = { :email => user.email, :password => '' }
    login_data_wrong_pass = { :email => user.email, :password => 'pass' }

    post '/api/v1/users/sign_in.json', params: login_data_none
    expect(response.status).to eq 401
    post '/api/v1/users/sign_in.json', params: login_data_no_email
    expect(response.status).to eq 401
    post '/api/v1/users/sign_in.json', params: login_data_no_pass
    expect(response.status).to eq 401
    post '/api/v1/users/sign_in.json', params: login_data_wrong_pass
    expect(response.status).to eq 401
  end
end