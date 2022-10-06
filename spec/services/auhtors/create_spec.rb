require 'rails_helper'

RSpec.describe Authors::Create, type: :model do
  describe '.call' do
    let!(:admin) { create :user, admin: true }

    context "and params doesn't pass author's name" do
      params = { 'birth_date(1i)' => '2022', 'birth_date(2i)' => '9',
                 'birth_date(3i)' => '29' }
      subject(:object) { Authors::Create.new(admin, params) }

      it "returns 'name is missing' error message" do
        expect(object.call).to eq [{ name: ['is missing'] }]
      end
    end

    context "and params doesn't pass author's birth_date" do
      params = { 'name' => 'Agatha Christie' }
      it 'successfully creates author' do
        author = Authors::Create.new(admin, params).call

        expect(author.name).to eq('Agatha Christie')
        expect(author.birth_date).to eq(nil)
      end
    end

    context "and params pass author's name and birth_date" do
      params = { 'name' => 'Agatha Christie', 'birth_date(1i)' => '2022', 'birth_date(2i)' => '9',
                 'birth_date(3i)' => '29' }

      it 'successfully creates author' do
        author = Authors::Create.new(admin, params).call

        expect(author.name).to eq('Agatha Christie')
        expect(author.birth_date).to eq('29/09/2022')
      end
    end
  end
end
