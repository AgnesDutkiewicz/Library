FactoryBot.define do
  factory :user do
    name { 'User' }
    email { 'user@example.com' }
    password { 'password' }
    admin { false }
  end
end
