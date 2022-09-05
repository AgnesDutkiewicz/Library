require 'rails_helper'

describe 'Navigating publishers' do
  let!(:publisher) { create :publisher }

  it 'allows navigation from the listing page to the detail page' do
    visit publishers_url

    click_link publisher.name

    expect(current_path).to eq(publisher_path(publisher))
  end

  it 'allows navigation from the detail page to the listing page' do
    visit publisher_url(publisher)

    click_link 'Publishers'

    expect(current_path).to eq(publishers_path)
  end
end
