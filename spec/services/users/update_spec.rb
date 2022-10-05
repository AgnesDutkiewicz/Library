require 'rails_helper'

RSpec.describe Users::Update, type: :model do
  describe '.call' do
    let!(:user) { create :user, admin: false }
    let!(:current_user) { create :user, name: 'current_user', admin: false }
    let!(:current_user_admin) { create :user, name: 'current_user_admin', admin: true }

    context 'when user is not signed in' do
      params = { 'name' => 'Lucas', 'email' => 'lucas@example.com', 'password' => 'password' }
      subject(:object) { Users::Update.new(nil, user, params) }

      it "returns 'user must be present' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be present' }]
      end
    end

    context 'when user is not an admin' do
      context "and he is trying to update another user's account" do
        params = { 'name' => 'Lucas', 'email' => 'lucas@example.com', 'password' => 'password' }
        subject(:object) { Users::Update.new(current_user, user, params) }

        it "returns 'user cant update another user' error message" do
          object.call

          expect(object.error_messages).to eq [{ user: 'cant update another user' }]
        end
      end

      context 'and he is trying to update his account' do
        params = { 'name' => 'Lucas', 'email' => 'lucas@example.com', 'password' => 'password' }

        it 'successfully updates user' do
          Users::Update.new(user, user, params).call

          expect(user.name).to eq('Lucas')
          expect(user.email).to eq('lucas@example.com')
        end
      end
    end

    context 'when user is admin' do
      context "and user's name is changed to blank" do
        params = { 'name' => '', 'email' => 'lucas@example.com', 'password' => 'password' }
        subject(:object) { Users::Update.new(current_user_admin, user, params) }

        it "returns 'name must be filled' error message" do
          expect(object.call).to eq [{ name: ['must be filled'] }]
        end
      end

      context "and user's email is changed to blank" do
        params = { 'name' => 'Lucas', 'email' => '', 'password' => 'password' }
        subject(:object) { Users::Update.new(current_user_admin, user, params) }

        it "returns 'email must be filled' error message" do
          expect(object.call).to eq [{ email: ['must be filled'] }]
        end
      end

      context "and user's password is blank" do
        params = { 'name' => 'Lucas', 'email' => 'lucas@example.com', 'password' => '' }
        subject(:object) { Users::Update.new(current_user_admin, user, params) }

        it "returns 'password must be filled' error message" do
          expect(object.call).to eq [{ password: ['must be filled'] }]
        end
      end

      context "and params pass user's name, email and password" do
        params = { 'name' => 'Lucas', 'email' => 'lucas@example.com', 'password' => 'password' }

        it 'successfully updates user' do
          Users::Update.new(current_user_admin, user, params).call

          expect(user.name).to eq('Lucas')
          expect(user.email).to eq('lucas@example.com')
        end
      end
    end
  end
end
