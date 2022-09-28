require 'rails_helper'
require 'dry-validation'

describe Publishers::UpdateContract do
  subject(:create_object) { Publishers::UpdateContract.new }

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

  context '#origin' do
    it { expect(create_object.call({ origin: nil }).errors[:origin].present?).to eq true }
    it { expect(create_object.call({ origin: 777 }).errors[:origin].present?).to eq true }
    it { expect(create_object.call({ origin: Time.now }).errors[:origin].present?).to eq true }
    it { expect(create_object.call({ origin: [] }).errors[:origin].present?).to eq true }
    it { expect(create_object.call({ origin: ['USA'] }).errors[:origin].present?).to eq true }
    it { expect(create_object.call({}).errors[:origin].present?).to eq false }
    it { expect(create_object.call({ origin: '' }).errors[:origin].present?).to eq false }
    it { expect(create_object.call({ origin: 'USA' }).errors[:origin].present?).to eq false }
  end
end
