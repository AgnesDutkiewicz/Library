require 'rails_helper'
require 'dry-validation'

describe Authors::UpdateContract do
  subject(:create_object) { Authors::UpdateContract.new }

  context '#name' do
    it { expect(create_object.call({ name: '' }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: nil }).errors[:name].present?).to eq true }
    it { expect(create_object.call({}).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: 9999 }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: Time.now }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: [] }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: ['Wojtek'] }).errors[:name].present?).to eq true }
    it { expect(create_object.call({ name: 'Wojtek' }).errors[:name].present?).to eq false }
  end

  context '#birth_date' do
    it { expect(create_object.call({ birth_date: 9999 }).errors[:birth_date].present?).to eq true }
    it { expect(create_object.call({ birth_date: 'Wojtek' }).errors[:birth_date].present?).to eq true }
    it { expect(create_object.call({ birth_date: Time.now }).errors[:birth_date].present?).to eq true }
    it { expect(create_object.call({ birth_date: [] }).errors[:birth_date].present?).to eq true }
    it { expect(create_object.call({ birth_date: [DateTime.now] }).errors[:birth_date].present?).to eq true }
    it { expect(create_object.call({}).errors[:birth_date].present?).to eq false }
    it { expect(create_object.call({ birth_date: '' }).errors[:birth_date].present?).to eq false }
    it { expect(create_object.call({ birth_date: nil }).errors[:birth_date].present?).to eq false }
    it { expect(create_object.call({ birth_date: DateTime.now }).errors[:birth_date].present?).to eq false }
  end
end
