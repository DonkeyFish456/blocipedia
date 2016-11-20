FactoryGirl.define do
  factory :user do
    username 'Stan'
    email 'stancalderon@gmail.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at Date.today
    role 'admin'
  end
end