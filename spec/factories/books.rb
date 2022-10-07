FactoryBot.define do
  factory :book do
    title { 'Lord of the Rings' }
    publication_date { '1981-01-01' }
    category { '10+' }
    association :publisher, factory: :publisher
  end

  factory :author do
    name { 'John Tolkien' }
    birth_date { '2017-01-01' }
  end

  factory :book_with_author, parent: :book do
    authors { [FactoryBot.create(:author)] }
  end

  factory :book_with_author2, parent: :book do
    authors { [FactoryBot.create(:author, name: 'Joanne Rowling')] }
  end
end
