require 'rails_helper'

describe 'Publisher#show' do
  let!(:publisher1) { create :publisher }
  let!(:publisher2) { create :publisher, name: 'Other Publishers Name' }

  context 'when there is more than one publisher in database' do
    it 'shows only one publisher details' do
      visit publisher_url(publisher1)

      expect(page).to have_text(publisher1.name)
      expect(page).to have_text(publisher1.origin)
      expect(page).to_not have_text(publisher2.name)
    end
  end
end
