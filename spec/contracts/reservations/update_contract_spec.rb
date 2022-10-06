require 'rails_helper'
require 'dry-validation'

describe Reservations::UpdateContract do
  subject(:create_object) { Reservations::UpdateContract.new }

  context '#status' do
    it { expect(create_object.call({ status: '' }).errors[:status].present?).to eq true }
    it { expect(create_object.call({ status: nil }).errors[:status].present?).to eq true }
    it { expect(create_object.call({}).errors[:status].present?).to eq true }
    it { expect(create_object.call({ status: 'Some id' }).errors[:status].present?).to eq true }
    it { expect(create_object.call({ status: [] }).errors[:status].present?).to eq true }
    it { expect(create_object.call({ status: [3122] }).errors[:status].present?).to eq true }
    it { expect(create_object.call({ status: 3243 }).errors[:status].present?).to eq true }
    it { expect(create_object.call({ status: 3 }).errors[:status].present?).to eq false }
    it { expect(create_object.call({ status: 2 }).errors[:status].present?).to eq false }
  end

  context '#return_date' do
    it { expect(create_object.call({ return_date: '' }).errors[:return_date].present?).to eq true }
    it { expect(create_object.call({ return_date: nil }).errors[:return_date].present?).to eq true }
    it { expect(create_object.call({ return_date: 13_121 }).errors[:return_date].present?).to eq true }
    it { expect(create_object.call({ return_date: [] }).errors[:return_date].present?).to eq true }
    it { expect(create_object.call({ return_date: [DateTime.now] }).errors[:return_date].present?).to eq true }
    it { expect(create_object.call({ return_date: 'Some date' }).errors[:return_date].present?).to eq true }
    it { expect(create_object.call({ return_date: DateTime.now }).errors[:return_date].present?).to eq false }
  end
end
