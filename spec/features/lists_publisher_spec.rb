require 'rails_helper'

describe 'Publisher#index' do
  context 'when there is one publisher in database' do
    let!(:publisher1) { create :publisher }

    it "lists publisher's name" do
      visit publishers_url

      expect(page).to have_text(publisher1.name)
    end
  end

  context 'when there is more then one publisher in database' do
    let!(:publisher1) { create :publisher }
    let!(:publisher2) { create :publisher, name: 'Other Publishers Name' }

    it 'lists all publishers names' do
      visit publishers_url

      expect(page).to have_text(publisher1.name)
      expect(page).to have_text(publisher2.name)
    end
  end
end
