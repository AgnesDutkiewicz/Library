require 'rails_helper'

describe 'Books#show' do
  let!(:book1) { create :book }
  let!(:book2) { create :book, title: 'Harry Potter and the Prisoner of Azkaban' }

  it 'shows only one book details' do
    visit book_url(book1)

    expect(page).to have_text(book1.title)
    expect(page).to have_text(book1.author)
    expect(page).to have_text(book1.publisher)
    expect(page).to have_text(book1.publication_date)
    expect(page).to_not have_text(book2.title)
  end
end
