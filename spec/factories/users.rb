# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    phone '16045061301'
    email 'example@example.com'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
