require 'rails_helper'

describe 'Navigating books' do
  let!(:book) { create :book }

  it 'allows navigation from the listing page to the detail page' do
    visit books_url

    click_link book.title

    expect(current_path).to eq(book_path(book))
  end

  it 'allows navigation from the detail page to the listing page' do
    visit book_url(book)

    click_link 'All Books'

    expect(current_path).to eq(books_path)
  end
end
