FactoryBot.define do
  factory :book do
    title { 'Lord of the Rings' }
    publication_date { '1981-01-01' }
    author { 'J. R. R. Tolkien' }
    publisher { 'Amber' }
  end
end
