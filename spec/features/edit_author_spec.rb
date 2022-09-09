require 'rails_helper'

describe 'Editing author' do
  let!(:author) { create :author }

  context 'when name is changed' do
    it "updates author and shows the author's updated details" do
      visit author_url(author)

      click_link 'Edit'

      expect(current_path).to eq(edit_author_path(author))
      expect(find_field('Name').value).to eq(author.name)

      fill_in 'Name', with: 'New Name'
      click_button 'Update Author'

      expect(current_path).to eq(author_path(author))
      expect(page).to have_text('New Name')
      expect(page).to have_text('Author successfully updated!')
    end
  end

  context 'when birth_year is changed' do
    it "updates author and shows the author's updated details" do
      visit author_url(author)

      click_link 'Edit'

      expect(current_path).to eq(edit_author_path(author))
      expect(find_field('Birth year').value).to eq('1892')

      fill_in 'Birth year', with: '1500'
      click_button 'Update Author'

      expect(current_path).to eq(author_path(author))
      expect(page).to have_text('1500')
      expect(page).to have_text('Author successfully updated!')
    end
  end

  context 'when name is changed to blank ' do
    it 'fails to update author' do
      visit edit_author_url(author)

      fill_in 'Name', with: ''

      click_button 'Update Author'

      expect(page).to have_text('Editing author:')
      expect(page).to have_text('error')
    end
  end
end
