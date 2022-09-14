require 'rails_helper'

describe 'Editing book' do
  let!(:publisher) { create :publisher }
  let!(:book) { create :book_with_author }

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

  context 'when title is changed to blank' do
    it 'fails to update book' do
      visit edit_book_url(book)

      fill_in 'Title', with: ''

      click_button 'Update Book'

      expect(page).to have_text('Editing book:')
      expect(current_path).to eq(book_path(book))
      expect(page).to have_text('error')
    end
  end
end
