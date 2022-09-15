require 'rails_helper'

describe 'Creating new author' do
  let!(:author) { create :author }

  context 'when all attributes are given' do
    it "saves the author and shows the new author's details" do
      visit authors_url

      click_link 'Add New Author'

      expect(current_path).to eq(new_author_path)

      fill_in 'Name', with: 'New Author'
      fill_in 'Birth year', with: '2000'

      click_button 'Create Author'

      expect(current_path).to eq(author_path(Author.last))
      expect(page).to have_text('New Author')
      expect(page).to have_text('2000')
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

      fill_in 'Birth year', with: '2000'

      expect do
        click_button 'Create Author'
      end.not_to change(Author, :count)
      expect(page).to have_text('error')

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
