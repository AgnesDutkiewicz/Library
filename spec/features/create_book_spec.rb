require 'rails_helper'

describe 'Creating new book' do
  it "saves the book and shows the new book's details" do
    visit books_url

    click_link 'Add New Book'

    expect(current_path).to eq(new_book_path)

    fill_in 'Title', with: 'New Book Title'
    select (Time.now.year - 1), from: 'book_publication_date_1i'
    fill_in 'Author', with: 'This Great Author'
    fill_in 'Publisher', with: 'Some Publisher'

    click_button 'Create Book'

    expect(current_path).to eq(book_path(Book.last))
    expect(page).to have_text('New Book Title')
    expect(page).to have_text('Book successfully created!')
  end

  it "does not save the book if it's invalid" do
    visit new_book_url

    expect {
      click_button 'Create Book'
    }.not_to change(Book, :count)

    expect(current_path).to eq(books_path)
  end
end
