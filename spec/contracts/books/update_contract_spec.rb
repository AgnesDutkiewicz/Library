require 'rails_helper'
require 'dry-validation'

describe Books::UpdateContract do
  subject(:create_object) { Books::UpdateContract.new }

  context '#title' do
    it { expect(create_object.call({ publisher_id: 5, author_ids: [2, 5, 7], title: '' }).success?).to eq false }
    it { expect(create_object.call({ publisher_id: 5, author_ids: [2, 5, 7], title: nil }).success?).to eq false }
    it { expect(create_object.call({ publisher_id: 5, author_ids: [2, 5, 7] }).success?).to eq false }
    it { expect(create_object.call({ publisher_id: 5, author_ids: [2, 5, 7], title: 1234 }).success?).to eq false }
    it { expect(create_object.call({ publisher_id: 5, author_ids: [2, 5, 7], title: [] }).success?).to eq false }
    it { expect(create_object.call({ publisher_id: 5, author_ids: [2, 5, 7], title: 'Book Title' }).success?).to eq true }
  end

  context '#publication_date' do
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7], publication_date: '' }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7], publication_date: nil }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7], publication_date: 13121}).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7], publication_date: [] }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7], publication_date: [ DateTime.now ]}).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7], publication_date: 'Dome date' }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7], publication_date: DateTime.now }).success?).to eq true }
  end

  context '#author_ids' do
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: '' }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: nil }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5 }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: 678 }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: Time.now }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: 'Some id' }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [] }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: ['a', 'b'] }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', publisher_id: 5, author_ids: [2, 5, 7] }).success?).to eq true }
  end

  context '#publisher_id' do
    it { expect(create_object.call({ title: 'The Demon King', author_ids: [2, 5, 7], publisher_id: '' }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', author_ids: [2, 5, 7], publisher_id: nil }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', author_ids: [2, 5, 7] }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', author_ids: [2, 5, 7], publisher_id: 'Some id' }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', author_ids: [2, 5, 7], publisher_id: [] }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', author_ids: [2, 5, 7], publisher_id: [3122] }).success?).to eq false }
    it { expect(create_object.call({ title: 'The Demon King', author_ids: [2, 5, 7], publisher_id: 3243 }).success?).to eq true }
  end
end
