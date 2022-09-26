require 'rails_helper'

describe 'Editing book' do
  let!(:publisher) { create :publisher }
  let!(:book) { create :book_with_author }
  let!(:admin) { create :user, admin: true }

  before do
    login
  end

  context 'when the title is changed' do
    it "updates book and shows the book's updated details" do
      visit book_url(book)

      click_link 'Edit'

      expect(current_path).to eq(edit_book_path(book))
      expect(find_field('Title').value).to eq(book.title)

      fill_in 'Title', with: 'Updated Title'
      click_button 'Update Book'

      expect(current_path).to eq(book_path(book))
      expect(page).to have_text('Updated Title')
      expect(page).to have_text('Book successfully updated!')
    end
  end

  context 'when the author is changed' do
    let!(:author) { create :author, name: 'Stephen King' }

    it "updates book and shows the book's updated details" do
      visit book_url(book)

      click_link 'Edit'

      expect(current_path).to eq(edit_book_path(book))
      expect(find_field('Title').value).to eq(book.title)

      uncheck 'John Tolkien'
      check 'Stephen King'

      click_button 'Update Book'

      expect(current_path).to eq(book_path(book))
      expect(page).to have_text('Stephen King')
      expect(page).to have_text('Book successfully updated!')
    end
  end

  context 'when publication_date is changed' do
    it "updates book and shows the book's updated details" do
      visit book_url(book)

      click_link 'Edit'

      expect(current_path).to eq(edit_book_path(book))
      expect(find_field('Title').value).to eq(book.title)

      select '2022', from: 'author_birth_date_1i'
      select 'May', from: 'author_birth_date_2i'
      select '15', from: 'author_birth_date_3i'

      click_button 'Update Book'

      expect(current_path).to eq(book_path(book))
      expect(page).to have_text('Updated Title')
      expect(page).to have_text('Book successfully updated!')
    end
  end

  context 'when title is changed to blank' do
    it 'fails to update book' do
      visit edit_book_url(book)

      fill_in 'Title', with: ''

      expect do
        click_button 'Update Book'
      end.not_to change(book, :title)
    end
  end
end
