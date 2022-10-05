require 'rails_helper'

RSpec.describe Authors::Update, type: :model do
  describe '.call' do
    let!(:user) { create :user, admin: false }
    let!(:admin) { create :user, admin: true }
    let!(:author) { create :author }

    context 'when user is not signed in' do
      params = { 'name' => 'Agatha Christie', 'birth_date(1i)' => '2022', 'birth_date(2i)' => '9',
                 'birth_date(3i)' => '29' }
      subject(:object) { Authors::Update.new(nil, author, params) }

      it "returns 'user must be present' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be present' }]
      end
    end

    context 'when user is not an admin' do
      params = { 'name' => 'Agatha Christie', 'birth_date(1i)' => '2022', 'birth_date(2i)' => '9',
                 'birth_date(3i)' => '29' }
      subject(:object) { Authors::Update.new(user, author, params) }

      it "returns 'user must be an admin' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be an admin' }]
      end
    end

    context 'when user is admin' do
      context "and author's name is changed to blank" do
        params = { 'name' => '' }
        subject(:object) { Authors::Update.new(admin, author, params) }

        it "returns 'name must be filled' error message" do
          expect(object.call).to eq [{ name: ['must be filled'] }]
        end
      end

      context "and author's birth_date is changed to blank" do
        params = { 'name' => 'Agatha Christie', 'birth_date(1i)' => '', 'birth_date(2i)' => '',
                   'birth_date(3i)' => '' }
        it "successfully updates author's birth_date" do
          Authors::Update.new(admin, author, params).call

          expect(author.birth_date).to eq(nil)
        end
      end

      context "and params pass author's name and birth_date" do
        params = { 'name' => 'Agatha Christie', 'birth_date(1i)' => '2022', 'birth_date(2i)' => '9',
                   'birth_date(3i)' => '29' }

        it 'successfully updates author' do
          Authors::Update.new(admin, author, params).call

          expect(author.name).to eq('Agatha Christie')
          expect(author.birth_date).to eq('29/09/2022')
        end
      end
    end
  end
end
