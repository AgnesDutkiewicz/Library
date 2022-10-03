require 'rails_helper'

describe 'Editing publisher' do
  let!(:publisher) { create :publisher }
  let!(:admin) { create :user, admin: true }

  before do
    login
  end

  context 'when name is changed' do
    it "updates publisher and shows the publisher's updated details" do
      visit publisher_url(publisher)

      click_link 'Edit'

      expect(current_path).to eq(edit_publisher_path(publisher))
      expect(find_field('Name').value).to eq(publisher.name)

      fill_in 'Name', with: 'Updated Name'
      click_button 'Update Publisher'

      expect(current_path).to eq(publisher_path(publisher))
      expect(page).to have_text('Updated Name')
      expect(page).to have_text('Publisher successfully updated!')
    end
  end

  context 'when origin (origin country) is changed' do
    it "updates publisher and shows the publisher's updated details" do
      visit publisher_url(publisher)

      click_link 'Edit'

      expect(current_path).to eq(edit_publisher_path(publisher))
      expect(find_field('Name').value).to eq(publisher.name)

      fill_in 'Origin', with: 'Updated Origin'
      click_button 'Update Publisher'

      expect(current_path).to eq(publisher_path(publisher))
      expect(page).to have_text('Updated Origin')
      expect(page).to have_text('Publisher successfully updated!')
    end
  end

  context 'when name is changed to blank' do
    it 'fails to update publisher' do
      visit edit_publisher_url(publisher)

      fill_in 'Name', with: ''

      expect do
        click_button 'Update Publisher'
      end.not_to change(publisher, :name)
    end
  end
end
