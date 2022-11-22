FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    username { Faker::Internet.username }
    bio { 'I work at statefarm' }
  end
end
