require 'rails_helper'

describe 'Editing book' do
  let!(:book) { create :book }

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

  it "does not update the book if it's invalid" do
    visit edit_book_url(book)

    fill_in 'Title', with: ''

    click_button 'Update Book'

    expect(page).to have_text('Editing book:')
  end
end
