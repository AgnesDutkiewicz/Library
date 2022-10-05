require 'rails_helper'

RSpec.describe Users::Create, type: :model do
  describe '.call' do

    context "when params doesnt pass user's name" do
      params = { 'email' => 'lucas@example.com', 'password' => 'secret' }
      subject(:object) { Users::Create.new(params) }

      it "returns 'name is missing' error message" do
        expect(object.call).to eq [{ name: ['is missing'] }]
      end
    end

    context "when params doesnt pass user's email" do
      params = { 'name' => 'Lucas', 'password' => 'secret' }
      subject(:object) { Users::Create.new(params) }

      it "returns 'email is missing' error message" do
        expect(object.call).to eq [{ email: ['is missing'] }]
      end
    end

    context "when params doesnt pass user's password" do
      params = { 'name' => 'Lucas', 'email' => 'lucas@example.com' }
      subject(:object) { Users::Create.new(params) }

      it "returns 'password is missing' error message" do
        expect(object.call).to eq [{ password: ['is missing'] }]
      end
    end

    context "and params pass publisher's name and birth_date" do
      params = { 'name' => 'Lucas', 'email' => 'lucas@example.com', 'password' => 'secret' }

      it 'successfully creates publisher' do
        user = Users::Create.new(params).call

        expect(user.name).to eq('Lucas')
        expect(user.email).to eq('lucas@example.com')
      end
    end
  end
end
