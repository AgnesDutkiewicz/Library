require 'rails_helper'

describe 'Navigating authors' do
  let!(:book) { create :book_with_author }

  context 'Authors#index' do
    it 'allows navigation to authors#show' do
      visit authors_url

      click_link 'John Tolkien'

      expect(page).to have_text('John Tolkien')
      expect(page).to have_text((DateTime.now - 100.years).strftime('%d-%m-%Y'))
    end
  end

  context 'Authors#show' do
    it 'allows navigation from to authors#index' do
      visit author_url(1)

      click_link 'Authors'

      expect(current_path).to eq(authors_path)
    end

    it "allows navigation to author's books" do
      visit author_url(1)

      click_link book.title

      expect(current_path).to eq(book_path(book))
    end
  end
end
