# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :smith, :class=>Provider do
    name 'Dr. Smith'
    phone '16045550001'

  end

  factory :jones, :class=>Provider do
    name 'Dr. Jones'
    phone '16045550002'
  end
end
