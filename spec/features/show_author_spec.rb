require 'rails_helper'

describe 'Authors#show' do
  let!(:author1) { create :author }
  let!(:author2) { create :author, name: 'Trudi Canavan' }

  context 'when there is more than one author in database' do
    it "shows only one author's details" do
      visit author_url(author1)

      expect(page).to have_text(author1.name)
      expect(page).to have_text(author1.birth_date.strftime('%d-%m-%Y'))
      expect(page).to_not have_text(author2.name)
    end
  end
end
