require 'rails_helper'
require 'dry-validation'

describe Reservations::CreateContract do
  subject(:create_object) { Reservations::CreateContract.new }

  context '#book_id' do
    it {
      expect(create_object.call({ user_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  book_id: '' }).success?).to eq false
    }
    it {
      expect(create_object.call({ user_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  book_id: nil }).success?).to eq false
    }
    it {
      expect(create_object.call({ user_id: 3, status: 1, return_date: DateTime.now + 7.days }).success?).to eq false
    }
    it {
      expect(create_object.call({ user_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  book_id: 'Some id' }).success?).to eq false
    }
    it {
      expect(create_object.call({ user_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  book_id: [] }).success?).to eq false
    }
    it {
      expect(create_object.call({ user_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  book_id: [3122] }).success?).to eq false
    }
    it {
      expect(create_object.call({ user_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  book_id: 3243 }).success?).to eq true
    }
  end

  context '#user_id' do
    it {
      expect(create_object.call({ book_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  user_id: '' }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  user_id: nil }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, status: 1, return_date: DateTime.now + 7.days }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  user_id: 'Some id' }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  user_id: [] }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  user_id: [3122] }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, status: 1, return_date: DateTime.now + 7.days,
                                  user_id: 3243 }).success?).to eq true
    }
  end

  context '#status' do
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: '' }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: nil }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: 'Some id' }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: [] }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: [3122] }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: 3243 }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: 3 }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 1, return_date: DateTime.now + 7.days,
                                  status: 2 }).success?).to eq true
    }
  end

  context '#return_date' do
    it { expect(create_object.call({ book_id: 3, user_id: 3122, status: 1, return_date: '' }).success?).to eq false }
    it { expect(create_object.call({ book_id: 3, user_id: 3122, status: 1, return_date: nil }).success?).to eq false }
    it {
      expect(create_object.call({ book_id: 3, user_id: 3122, status: 1, return_date: 13_121 }).success?).to eq false
    }
    it { expect(create_object.call({ book_id: 3, user_id: 3122, status: 1, return_date: [] }).success?).to eq false }
    it {
      expect(create_object.call({ book_id: 3, user_id: 3122, status: 1,
                                  return_date: [DateTime.now] }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 3122, status: 1,
                                  return_date: 'Some date' }).success?).to eq false
    }
    it {
      expect(create_object.call({ book_id: 3, user_id: 3122, status: 1,
                                  return_date: DateTime.now }).success?).to eq true
    }
  end
end
