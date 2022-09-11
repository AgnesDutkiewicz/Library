require 'rails_helper'

describe 'Creating new book' do
  context
  let!(:publisher) { create :publisher }
  let!(:author) { create :author }

  context 'when all attributes are given' do
    it "saves the book and shows the new book's details" do
      visit books_url

      click_link 'Add New Book'

      expect(current_path).to eq(new_book_path)

      fill_in 'Title', with: 'New Book Title'
      select (Time.now.year - 1), from: 'book_publication_date_1i'
      check 'John Tolkien'
      select publisher.name, from: 'book_publisher_id'

      click_button 'Create Book'

      expect(current_path).to eq(book_path(Book.last))
      expect(page).to have_text('New Book Title')
      expect(page).to have_text('John Tolkien')
      expect(page).to have_text('Book successfully created!')
    end
  end

  context 'when title is blank' do
    it 'fails to create book' do
      visit books_url

      click_link 'Add New Book'

      expect(current_path).to eq(new_book_path)

      fill_in 'Title', with: ''
      select (Time.now.year - 1), from: 'book_publication_date_1i'
      check 'John Tolkien'
      select publisher.name, from: 'book_publisher_id'

      expect do
        click_button 'Create Book'
      end.not_to change(Book, :count)
      expect(current_path).to eq(books_path)
      expect(page).to have_text('error')
    end
  end

  context 'when author is not picked' do
    it 'fails to create book' do
      visit books_url

      click_link 'Add New Book'

      expect(current_path).to eq(new_book_path)

      fill_in 'Title', with: 'New Book Title'
      select (Time.now.year - 1), from: 'book_publication_date_1i'
      select publisher.name, from: 'book_publisher_id'

      click_button 'Create Book'

      expect do
        click_button 'Create Book'
      end.not_to change(Book, :count)
      expect(current_path).to eq(books_path)
      expect(page).to have_text('error')
    end
  end
end
