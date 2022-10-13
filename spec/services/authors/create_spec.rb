require 'rails_helper'

RSpec.describe Authors::Create, type: :model do
  describe '.call' do

    context "and params doesn't pass author's name" do
      params = { 'birth_date(1i)' => '2022', 'birth_date(2i)' => '9',
                 'birth_date(3i)' => '29' }
      subject(:object) { Authors::Create.new(params) }
      it "returns 'name is missing' error message" do


        expect(object.call).not_to be_success
        expect(object.call.failure).to eq({:name=>["is missing"]})
      end
    end

    context "and params doesn't pass author's birth_date" do
      params = { 'name' => 'Agatha Christie' }
      subject(:object) { Authors::Create.new(params) }
      it 'successfully creates author' do

        expect(object.call).to be_success
        expect(object.call.value!).to eq Author.last
        expect(Author.last.name).to eq('Agatha Christie')
        expect(Author.last.birth_date).to eq(nil)
      end
    end

    context "and params pass author's name and birth_date" do
      params = { 'name' => 'Agatha Christie', 'birth_date(1i)' => '2022', 'birth_date(2i)' => '9',
                 'birth_date(3i)' => '29' }
      subject(:object) { Authors::Create.new(params) }
      it 'successfully creates author' do

        expect(object.call).to be_success
        expect(object.call.value!).to eq Author.last
        expect(Author.last.name).to eq('Agatha Christie')
        expect(Author.last.birth_date).to eq('29-09-2022')
      end
    end
  end
end
