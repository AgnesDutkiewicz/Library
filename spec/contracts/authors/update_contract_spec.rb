require 'rails_helper'
require 'dry-validation'

describe Authors::UpdateContract do
  subject(:create_object) { Authors::UpdateContract.new }

  context '#name' do
    it { expect(create_object.call({ name: '' }).success?).to eq false }
    it { expect(create_object.call({ name: nil }).success?).to eq false }
    it { expect(create_object.call({}).success?).to eq false }
    it { expect(create_object.call({ name: 9999 }).success?).to eq false }
    it { expect(create_object.call({ name: Time.now }).success?).to eq false }
    it { expect(create_object.call({ name: [] }).success?).to eq false }
    it { expect(create_object.call({ name: ['Wojtek'] }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek' }).success?).to eq true }
  end

  context '#birth_date' do
    it { expect(create_object.call({ name: 'Wojtek', birth_date: '' }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek', birth_date: nil }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek', birth_date: 9999 }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek', birth_date: 'Wojtek' }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek', birth_date: Time.now }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek', birth_date: [] }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek', birth_date: [DateTime.now] }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek' }).success?).to eq true }
    it { expect(create_object.call({ name: 'Wojtek', birth_date: DateTime.now }).success?).to eq true }
  end
end
