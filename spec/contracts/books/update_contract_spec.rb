require 'rails_helper'
require 'dry-validation'

describe Books::UpdateContract do
  subject(:create_object) { Books::UpdateContract.new }

  context '#title' do
    it { expect(create_object.call({ title: '' }).errors[:title].present?).to eq true }
    it { expect(create_object.call({ title: nil }).errors[:title].present?).to eq true }
    it { expect(create_object.call({}).errors[:title].present?).to eq true }
    it { expect(create_object.call({ title: 1234 }).errors[:title].present?).to eq true }
    it { expect(create_object.call({ title: [] }).errors[:title].present?).to eq true }
    it { expect(create_object.call({ title: 'Book Title' }).errors[:title].present?).to eq false }
  end

  context '#publication_date' do
    it { expect(create_object.call({ publication_date: '' }).errors[:publication_date].present?).to eq true }
    it { expect(create_object.call({ publication_date: nil }).errors[:publication_date].present?).to eq true }
    it { expect(create_object.call({ publication_date: 13_121 }).errors[:publication_date].present?).to eq true }
    it { expect(create_object.call({ publication_date: [] }).errors[:publication_date].present?).to eq true }
    it { expect(create_object.call({ publication_date: [DateTime.now] }).errors[:publication_date].present?).to eq true }
    it { expect(create_object.call({ publication_date: 'Some date' }).errors[:publication_date].present?).to eq true }
    it { expect(create_object.call({ publication_date: DateTime.now }).errors[:publication_date].present?).to eq false }
  end

  context '#author_ids' do
    it { expect(create_object.call({ author_ids: '' }).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({ author_ids: nil }).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({}).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({ author_ids: 678 }).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({ author_ids: Time.now }).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({ author_ids: 'Some id' }).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({ author_ids: [] }).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({ author_ids: %w[a b] }).errors[:author_ids].present?).to eq true }
    it { expect(create_object.call({ author_ids: [2, 5, 7] }).errors[:author_ids].present?).to eq false }
  end

  context '#publisher_id' do
    it { expect(create_object.call({ publisher_id: '' }).errors[:publisher_id].present?).to eq true }
    it { expect(create_object.call({ publisher_id: nil }).errors[:publisher_id].present?).to eq true }
    it { expect(create_object.call({}).errors[:publisher_id].present?).to eq true }
    it { expect(create_object.call({ publisher_id: 'Some id' }).errors[:publisher_id].present?).to eq true }
    it { expect(create_object.call({ publisher_id: [] }).errors[:publisher_id].present?).to eq true }
    it { expect(create_object.call({ publisher_id: [3122] }).errors[:publisher_id].present?).to eq true }
    it { expect(create_object.call({ publisher_id: 3243 }).errors[:publisher_id].present?).to eq false }
  end
end
