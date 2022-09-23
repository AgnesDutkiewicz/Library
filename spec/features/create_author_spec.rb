require 'rails_helper'

describe 'Creating new author' do
  let!(:admin) { create :user, admin: true }

  before do
    login
  end

  context 'when all attributes are given' do
    it "saves the author and shows the new author's details" do
      visit authors_url

      click_link 'Add New Author'

      expect(current_path).to eq(new_author_path)

      fill_in 'Name', with: 'New Author'
      select '2022', from: 'author_birth_date_1i'
      select 'May', from: 'author_birth_date_2i'
      select '15', from: 'author_birth_date_3i'

      click_button 'Create Author'

      expect(current_path).to eq(author_path(Author.last))
      expect(page).to have_text('New Author')
      expect(page).to have_text('2022/05/15'.to_date.strftime('%d-%m-%Y'))
      expect(page).to have_text('Author successfully created!')
    end
  end

  context 'when only name is given' do
    it "saves the author and shows the new author's details" do
      visit authors_url

      click_link 'Add New Author'

      expect(current_path).to eq(new_author_path)

      fill_in 'Name', with: 'New Author'

      click_button 'Create Author'

      expect(current_path).to eq(author_path(Author.last))
      expect(page).to have_text('New Author')
      expect(page).to have_text('Author successfully created!')
    end
  end

  context 'when only birth_year is given' do
    it 'fails to create author' do
      visit authors_url

      click_link 'Add New Author'

      select '2022', from: 'author_birth_date_1i'
      select 'May', from: 'author_birth_date_2i'
      select '15', from: 'author_birth_date_3i'

      expect do
        click_button 'Create Author'
      end.not_to change(Author, :count)
      expect(current_path).to eq(authors_path)
    end
  end

  context 'when no attributes are given' do
    it 'fails to create author' do
      visit new_author_url

      expect do
        click_button 'Create Author'
      end.not_to change(Author, :count)

      expect(current_path).to eq(authors_path)
    end
  end
end
