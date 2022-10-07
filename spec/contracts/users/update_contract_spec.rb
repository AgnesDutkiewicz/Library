require 'rails_helper'
require 'dry-validation'

describe Users::UpdateContract do
  let!(:user) { create :user }
  subject(:create_object) { Users::UpdateContract.new(user: user) }

  context '#name' do
    it { expect(create_object.call({ name: '' }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: nil }).errors[:name].present?).to eq true }
    it { expect(create_object.call({}).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: 777 }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: Time.now }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: [] }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: ['Luiza'] }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: 'Luiza' }).errors[:name].present?).to eq false }
  end

  context '#email' do
    it { expect(create_object.call({ email: '' }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: nil }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: 777 }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: Time.now }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: [] }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: ['agnes@example.com'] }).errors[:email].present?).to eq true }
    it { expect(create_object.call({}).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: '@example.com' }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: 'agnesexample.com' }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: 'agnes@.com' }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: 'agnes@examplecom' }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: 'agnes@example.' }).errors[:email].present?).to eq true }
    it { expect(create_object.call({ email: 'agnes@example.com' }).errors[:email].present?).to eq false }
  end

  context '#admin' do
    let!(:user) { create :user, admin: true }
    it { expect(create_object.call({ admin: '' }).errors[:admin].present?).to eq true }
    it { expect(create_object.call({ admin: nil }).errors[:admin].present?).to eq true }
    it { expect(create_object.call({ admin: 777 }).errors[:admin].present?).to eq true }
    it { expect(create_object.call({ admin: Time.now }).errors[:admin].present?).to eq true }
    it { expect(create_object.call({ admin: [] }).errors[:admin].present?).to eq true }
    it { expect(create_object.call({ admin: ['Luiza'] }).errors[:admin].present?).to eq true }
    it { expect(create_object.call({}).errors[:admin].present?).to eq false }
    it { expect(create_object.call({ admin: true }).errors[:admin].present?).to eq false }
    it { expect(create_object.call({ admin: false }).errors[:admin].present?).to eq false }
  end
end
