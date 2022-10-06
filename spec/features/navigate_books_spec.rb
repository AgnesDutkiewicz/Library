require 'rails_helper'

describe 'Navigating books' do
  let!(:book) { create :book_with_author }

  context 'Books#index' do
    it 'allows navigation to books#show' do
      visit books_url

      click_link book.title

      expect(current_path).to eq(book_path(book))
    end
  end

  context 'Books#show' do
    it 'allows navigation to books#index' do
      visit book_url(book)

      click_link 'Books'

      expect(current_path).to eq(books_path)
    end

    it "allows navigation to book's author" do
      visit book_url(book)

      click_link 'John Tolkien'

      expect(current_path).to eq(author_path(book.authors.first))
    end

    it "allows navigation to book's publisher" do
      visit book_url(book)

      click_link book.publisher.name

      expect(current_path).to eq(publisher_path(book.publisher))
    end
  end
end
