FactoryGirl.define do
    factory :user do
      email "test@example.com"
      password "!234abcD"
      password_confirmation "!234abcD"
    end

    factory :second_user do
      email "test2@example.com"
      password "!234abcD"
      password_confirmation "!234abcD"
    end
end