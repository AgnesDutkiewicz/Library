require 'rails_helper'

describe 'Creating new book' do

  context
  let!(:publisher1) { create :publisher }
  let!(:author) { create :author }

  it "saves the book and shows the new book's details" do
    visit books_url

    click_link 'Add New Book'

    expect(current_path).to eq(new_book_path)

    fill_in 'Title', with: 'New Book Title'
    select (Time.now.year - 1), from: 'book_publication_date_1i'
    check 'John Tolkien'
    select publisher1.name, from: 'book_publisher_id'

    click_button 'Create Book'

    expect(current_path).to eq(book_path(Book.last))
    expect(page).to have_text('New Book Title')
    expect(page).to have_text('John Tolkien')
    expect(page).to have_text('Book successfully created!')
  end

  it "does not save the book if it's invalid" do
    visit new_book_url

    expect do
      click_button 'Create Book'
    end.not_to change(Book, :count)

    expect(current_path).to eq(books_path)
  end
end
