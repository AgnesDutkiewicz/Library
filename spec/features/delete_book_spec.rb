require 'rails_helper'

describe 'Deleting a book' do
  let!(:book) { create :book_with_author }
  let!(:admin) { create :user, admin: true }

  before do
    login
  end

  it 'successfully destroys the book and shows the book#index page without the deleted book' do
    visit book_path(book)

    click_link 'Delete'

    expect(current_path).to eq(books_path)
    expect(page).not_to have_text(book.title)
    expect(page).to have_text('Book successfully deleted!')
  end
end
