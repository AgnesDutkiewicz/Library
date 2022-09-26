require 'rails_helper'

describe 'Creating new publisher' do
  let!(:admin) { create :user, admin: true }

  before do
    login
  end

  context 'when all attributes are given' do
    it "saves publisher and shows the new publisher's details" do
      visit publishers_url

      click_link 'Add New Publisher'

      expect(current_path).to eq(new_publisher_path)

      fill_in 'Name', with: 'Publishers Name'
      fill_in 'Origin', with: 'Some Country'

      click_button 'Create Publisher'

      expect(current_path).to eq(publisher_path(Publisher.last))
      expect(page).to have_text('Publishers Name')
      expect(page).to have_text('Some Country')
      expect(page).to have_text('Publisher successfully created!')
    end
  end

  context 'when origin (origin country) is blank' do
    it "saves publisher and shows the new publisher's details" do
      visit publishers_url

      click_link 'Add New Publisher'

      expect(current_path).to eq(new_publisher_path)

      fill_in 'Name', with: 'Publishers Name'

      click_button 'Create Publisher'

      expect(current_path).to eq(publisher_path(Publisher.last))
      expect(page).to have_text('Publishers Name')
      expect(page).to have_text('Publisher successfully created!')
    end
  end

  context 'when name is blank' do
    it 'fails to create publisher' do
      visit publishers_url

      click_link 'Add New Publisher'

      expect(current_path).to eq(new_publisher_path)

      fill_in 'Origin', with: 'Some Country'

      expect do
        click_button 'Create Publisher'
      end.not_to change(Publisher, :count)
      expect(current_path).to eq(publishers_path)
    end
  end
end
