require 'rails_helper'

describe 'Books#index' do
  context 'when there is one book in database' do
    let!(:book1) { create :book_with_author }

    it "lists book's title" do
      visit books_url

      expect(page).to have_text(book1.title)
    end
  end

  context 'when there is more than one in database' do
    let!(:book1) { create :book_with_author }
    let!(:book2) { create :book_with_author2, title: 'Harry Potter and the Prisoner of Azkaban' }

    it 'lists all books titles' do
      visit books_url

      expect(page).to have_text(book1.title)
      expect(page).to have_text(book2.title)
    end
  end
end
