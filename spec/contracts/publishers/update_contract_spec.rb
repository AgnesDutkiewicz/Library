require 'rails_helper'
require 'dry-validation'

describe Publishers::UpdateContract do
  subject(:create_object) { Publishers::UpdateContract.new }

  context '#name' do
    it { expect(create_object.call({ name: '' }).success?).to eq false }
    it { expect(create_object.call({ name: nil }).success?).to eq false }
    it { expect(create_object.call({}).success?).to eq false }
    it { expect(create_object.call({ name: 777 }).success?).to eq false }
    it { expect(create_object.call({ name: Time.now }).success?).to eq false }
    it { expect(create_object.call({ name: [] }).success?).to eq false }
    it { expect(create_object.call({ name: ['Luiza'] }).success?).to eq false }
    it { expect(create_object.call({ name: 'Luiza' }).success?).to eq true }
  end

  context '#origin' do
    it { expect(create_object.call({ name: 'John', origin: '' }).success?).to eq false }
    it { expect(create_object.call({ name: 'John', origin: nil }).success?).to eq false }
    it { expect(create_object.call({ name: 'John', origin: 777 }).success?).to eq false }
    it { expect(create_object.call({ name: 'John', origin: Time.now }).success?).to eq false }
    it { expect(create_object.call({ name: 'John', origin: [] }).success?).to eq false }
    it { expect(create_object.call({ name: 'John', origin: ['USA'] }).success?).to eq false }
    it { expect(create_object.call({ name: 'John' }).success?).to eq true }
    it { expect(create_object.call({ name: 'John', origin: 'USA' }).success?).to eq true }
  end
end
