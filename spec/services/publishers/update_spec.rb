require 'rails_helper'

RSpec.describe Publishers::Update, type: :model do
  describe '.call' do
    let!(:admin) { create :user, admin: true }
    let!(:publisher) { create :publisher }

    context "and publisher's name is changed to blank" do
      params = { 'name' => '', 'origin' => 'Publisher country' }
      subject(:object) { Publishers::Update.new(admin, publisher, params) }

      it "returns 'name must be filled' error message" do
        expect(object.call).to eq [{ name: ['must be filled'] }]
      end
    end

    context "and publisher's origin country is changed to blank" do
      params = { 'name' => 'Publisher name', 'origin' => '' }
      it "successfully updates publisher's origin county" do
        Publishers::Update.new(admin, publisher, params).call

        expect(publisher.origin).to eq('')
      end
    end

    context "and params pass publisher's name and birth_date" do
      params = { 'name' => 'Publisher name', 'origin' => 'Publisher country' }

      it 'successfully updates publisher' do
        Publishers::Update.new(admin, publisher, params).call

        expect(publisher.name).to eq('Publisher name')
        expect(publisher.origin).to eq('Publisher country')
      end
    end
  end
end
