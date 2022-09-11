require 'rails_helper'

describe 'Navigating publishers' do
  let!(:publisher1) { create :publisher }
  let!(:book) { create :book_with_author, publisher: publisher1 }

  context 'Publishers#index' do
    it 'allows navigation to publishers#show' do
      visit publishers_url

      click_link publisher1.name

      expect(current_path).to eq(publisher_path(publisher1))
    end
  end

  context 'Publishers#show' do
    it 'allows navigation from the detail page to the listing page' do
      visit publisher_url(publisher1)

      click_link 'Publishers'

      expect(current_path).to eq(publishers_path)
    end

    it "allows navigation to publisher's book" do
      visit publisher_url(publisher1)

      click_link book.title

      expect(current_path).to eq(book_path(book))
    end
  end
end
