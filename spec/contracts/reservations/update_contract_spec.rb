require 'rails_helper'
require 'dry-validation'

describe Reservations::UpdateContract do
  subject(:create_object) { Reservations::UpdateContract.new }

  context '#book_id' do
    it { expect(create_object.call({ book_id: '' }).errors[:book_id].present?).to eq true }
    it { expect(create_object.call({ book_id: nil }).errors[:book_id].present?).to eq true }
    it { expect(create_object.call({}).errors[:book_id].present?).to eq true }
    it { expect(create_object.call({ book_id: 'Some id' }).errors[:book_id].present?).to eq true }
    it { expect(create_object.call({ book_id: [] }).errors[:book_id].present?).to eq true }
    it { expect(create_object.call({ book_id: [3122] }).errors[:book_id].present?).to eq true }
    it { expect(create_object.call({ book_id: 3243 }).errors[:book_id].present?).to eq false }
  end

  context '#user_id' do
    it { expect(create_object.call({ user_id: '' }).errors[:user_id].present?).to eq true }
    it { expect(create_object.call({ user_id: nil }).errors[:user_id].present?).to eq true }
    it { expect(create_object.call({}).errors[:user_id].present?).to eq true }
    it { expect(create_object.call({ user_id: 'Some id' }).errors[:user_id].present?).to eq true }
    it { expect(create_object.call({ user_id: [] }).errors[:user_id].present?).to eq true }
    it { expect(create_object.call({ user_id: [3122] }).errors[:user_id].present?).to eq true }
    it { expect(create_object.call({ user_id: 3243 }).errors[:user_id].present?).to eq false }
  end

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