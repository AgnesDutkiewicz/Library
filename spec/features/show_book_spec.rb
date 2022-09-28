require 'rails_helper'

describe 'Books#show' do
  let!(:book1) { create :book_with_author }
  let!(:book2) { create :book_with_author2, title: 'Harry Potter and the Prisoner of Azkaban' }

  context 'when there is more than one book in database' do
    it 'shows only one book details' do
      visit book_url(book1)

      expect(page).to have_text(book1.title)
      expect(page).to have_text(book1.authors.name)
      expect(page).to have_text(book1.publisher.name)
      expect(page).to have_text(book1.publication_date.strftime('%d-%m-%Y'))
      expect(page).to_not have_text(book2.title)
    end
  end
end
