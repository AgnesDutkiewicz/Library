require 'rails_helper'

RSpec.describe Publishers::Create, type: :model do
  describe '.call' do

    context "and params doesn't pass publisher's name" do
      params = { 'origin' => 'Publisher country' }
      subject(:object) { Publishers::Create.new(params).call }
      it "returns 'name is missing' error message" do

        expect(object).not_to be_success
        expect(object.failure).to eq({ :name => ["is missing"] })
      end
    end

    context "and params doesn't pass publisher's origin country" do
      params = { 'name' => 'Publisher name' }
      subject(:object) { Publishers::Create.new(params).call }
      it 'successfully creates publisher' do
        publisher = object.value!

        expect(object).to be_success
        expect(publisher.name).to eq('Publisher name')
        expect(publisher.origin).to eq(nil)
      end
    end

    context "and params pass publisher's name and birth_date" do
      params = { 'name' => 'Publisher name', 'origin' => 'Publisher country' }
      subject(:object) { Publishers::Create.new(params).call }
      it 'successfully creates publisher' do
        publisher = object.value!

        expect(object).to be_success
        expect(publisher.name).to eq('Publisher name')
        expect(publisher.origin).to eq('Publisher country')
      end
    end
  end
end
