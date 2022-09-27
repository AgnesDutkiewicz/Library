require 'rails_helper'

describe 'Editing author' do
  let!(:author) { create :author }
  let!(:admin) { create :user, admin: true }

  before do
    login
  end

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

      select '2021', from: 'author_birth_date_1i'
      select 'May', from: 'author_birth_date_2i'
      select '15', from: 'author_birth_date_3i'

      click_button 'Update Author'

      expect(current_path).to eq(author_path(author))
      expect(page).to have_text('2021/05/15'.to_date.strftime('%d-%m-%Y'))
      expect(page).to have_text('Author successfully updated!')
    end
  end

  context 'when name is changed to blank' do
    it 'fails to update author' do
      visit edit_author_url(author)

      fill_in 'Name', with: ''

      expect do
        click_button 'Update Author'
      end.not_to change(Author, :name)
    end
  end
end
