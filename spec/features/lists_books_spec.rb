require 'rails_helper'

describe 'Books#index' do
  let!(:book1) { create :book }
  let!(:book2) { create :book, title: 'Harry Potter and the Prisoner of Azkaban' }

  it 'lists all books' do
    visit books_url

    expect(page).to have_text(book1.title)
    expect(page).to have_text(book2.title)
  end
end
