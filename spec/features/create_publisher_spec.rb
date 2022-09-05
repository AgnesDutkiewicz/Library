require 'rails_helper'

describe 'Creating new publisher' do
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

  it "does not save the publisher if it's invalid" do
    visit new_publisher_url

    expect do
      click_button 'Create Publisher'
    end.not_to change(Publisher, :count)

    expect(current_path).to eq(publishers_path)
  end
end
