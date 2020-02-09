FactoryBot.define do
  factory :user do
    name "Koufax"
    sequence :email do |n|
      "sandy#{n}@dodgers.com"
    end
    password '123456'
  end
end
