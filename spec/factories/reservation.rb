FactoryBot.define do
  factory :reservation do
    book_id { 1 }
    user_id { 1 }
    status { 0 }
    return_date { Time.now + 7.days }
  end
end
