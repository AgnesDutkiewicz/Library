require 'rails_helper'
require 'dry-validation'

describe Authors::CreateContract do
  subject(:create_object) { Authors::CreateContract.new }

  context '#name' do
    it { expect(create_object.call({ name: '' }).success?).to eq false }
    it { expect(create_object.call({ name: nil }).success?).to eq false }
    it { expect(create_object.call({}).success?).to eq false }
    it { expect(create_object.call({ name: 9999 }).success?).to eq false }
    it { expect(create_object.call({ name: Time.now }).success?).to eq false }
    it { expect(create_object.call({ name: 'Wojtek' }).success?).to eq true }
  end

  context '#birth_date' do
    it { expect(create_object.call({ birth_date: '' }).success?).to eq false }
    it { expect(create_object.call({ birth_date: nil }).success?).to eq false }
    it { expect(create_object.call({}).success?).to eq false }
    it { expect(create_object.call({ birth_date: 9999 }).success?).to eq false }
    it { expect(create_object.call({ birth_date: 'Wojtek' }).success?).to eq false }
    it { expect(create_object.call({ birth_date: Time.now }).success?).to eq false }

    # I want something like this to return true but it doesnt
    # it { expect(create_object.call({ birth_date: Time.now.to_datetime }).success?).to eq true }
  end
end
