require 'rails_helper'

describe 'Editing publisher' do
  let!(:publisher) { create :publisher }

  it "updates publisher and shows the publisher's updated details" do
    visit publisher_url(publisher)

    click_link 'Edit'

    expect(current_path).to eq(edit_publisher_path(publisher))
    expect(find_field('Name').value).to eq(publisher.name)

    fill_in 'Name', with: 'Updated Name'
    fill_in 'Origin', with: 'Updated Origin'
    click_button 'Update Publisher'

    expect(current_path).to eq(publisher_path(publisher))
    expect(page).to have_text('Updated Name')
    expect(page).to have_text('Updated Origin')
    expect(page).to have_text('Publisher successfully updated!')
  end

  it "does not update the publisher if it's invalid" do
    visit edit_publisher_url(publisher)

    fill_in 'Name', with: ''

    click_button 'Update Publisher'

    expect(page).to have_text('Editing publisher:')
  end
end
