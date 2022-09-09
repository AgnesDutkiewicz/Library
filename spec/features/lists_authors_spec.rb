require 'rails_helper'

describe 'Author#index' do
  context 'when there is 1 author in database' do
    let!(:author1) { create :author }

    it "lists author's name" do
      visit authors_url

      expect(page).to have_text(author1.name)
    end
  end

  context 'when there are 3 authors in database' do
    let!(:author1) { create :author }
    let!(:author2) { create :author, name: 'Trudi Canavan' }
    let!(:author3) { create :author, name: 'Anne Bishop' }

    it 'lists all authors names' do
      visit authors_url

      expect(page).to have_text(author1.name)
      expect(page).to have_text(author2.name)
      expect(page).to have_text(author3.name)
    end
  end
end
