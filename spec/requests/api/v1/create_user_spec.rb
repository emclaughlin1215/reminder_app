require 'rails_helper'

describe "User creation" do
  it "allows user creation with required fields" do
    expect(User.count).to eq 0

    user = FactoryGirl.build(:user)
    userparams = { :user => { :email => user.email, :password => user.password, :password_confirmation => user.password } }

    post '/api/v1/users.json', params: userparams

    expect(response).to be_success
    expect(User.count).to eq 1
  end

  it "does not allow user creation if passwords don't match" do
    expect(User.count).to eq 0

    user = FactoryGirl.build(:user)
    userparams = { :user => { :email => user.email, :password => user.password, :password_confirmation => "aaaaaaaa4cD!" } }

    post '/api/v1/users.json', params: userparams

    expect(response.status).to eq 422
    expect(User.count).to eq 0
  end

  it "does not allow user creation if password or email is empty" do
    expect(User.count).to eq 0

    user = FactoryGirl.build(:user)
    userparams = { :user => { :email => user.email } }

    post '/api/v1/users.json', params: userparams

    expect(response.status).to eq 422
    expect(User.count).to eq 0

    userparams = { :user => { :password => user.password, :password_confirmation => user.password } }

    post '/api/v1/users.json', params: userparams

    expect(response.status).to eq 422
    expect(User.count).to eq 0
  end

  # TODO: Make this work
  # it "does not allow user creation if user is already logged in" do
  #   user = FactoryGirl. build(:user)
  #   userparams = { :user => { :email => "newemail@gmail.com", :password => 'sup3rP!', :password_confirmation => 'sup3rP!' } }
  #   post '/api/v1/users.json', params: userparams

  #   expect(response.status).to eq 403
  #   expect(User.count).to eq 1
  # end
end