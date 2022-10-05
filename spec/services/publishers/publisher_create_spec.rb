require 'rails_helper'

RSpec.describe Publishers::Create, type: :model do
  describe '.call' do
    let!(:user) { create :user, admin: false }
    let!(:admin) { create :user, admin: true }

    context 'when user is not signed in' do
      params = { 'name' => 'Publisher name', 'origin' => 'Publisher country' }
      subject(:object) { Publishers::Create.new(nil, params) }

      it "returns 'user must be present' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be present' }]
      end
    end

    context 'when user is not an admin' do
      params = { 'name' => 'Publisher name', 'origin' => 'Publisher country' }
      subject(:object) { Publishers::Create.new(user, params) }

      it "returns 'user must be an admin' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be an admin' }]
      end
    end

    context 'when user is admin' do
      context "and params doesn't pass publisher's name" do
        params = { 'origin' => 'Publisher country' }
        subject(:object) { Publishers::Create.new(admin, params) }

        it "returns 'name is missing' error message" do
          expect(object.call).to eq [{ name: ['is missing'] }]
        end
      end

      context "and params doesn't pass publisher's origin country" do
        params = { 'name' => 'Publisher name' }
        it 'successfully creates publisher' do
          publisher = Publishers::Create.new(admin, params).call

          expect(publisher.name).to eq('Publisher name')
          expect(publisher.origin).to eq(nil)
        end
      end

      context "and params pass publisher's name and birth_date" do
        params = { 'name' => 'Publisher name', 'origin' => 'Publisher country' }

        it 'successfully creates publisher' do
          publisher = Publishers::Create.new(admin, params).call

          expect(publisher.name).to eq('Publisher name')
          expect(publisher.origin).to eq('Publisher country')
        end
      end
    end
  end
end
