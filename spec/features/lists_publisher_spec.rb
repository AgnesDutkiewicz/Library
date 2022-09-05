require 'rails_helper'

describe 'Publisher#index' do
  let!(:publisher1) { create :publisher }
  let!(:publisher2) { create :publisher, name: 'Other Publishers Name' }

  it 'lists all publishers' do
    visit publishers_url

    expect(page).to have_text(publisher1.name)
    expect(page).to have_text(publisher2.name)
  end
end
