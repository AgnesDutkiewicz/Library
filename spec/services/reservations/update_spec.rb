require 'rails_helper'

RSpec.describe Reservations::Update, type: :model do
  describe '.call' do
    let!(:user) { create :user, admin: false }
    let!(:admin) { create :user, admin: true }
    let!(:book) { create :book_with_author }
    let!(:reservation) { create :reservation, book_id: book.id, user_id: user.id }

    context "and reservation's status is changed to blank" do
      params = { 'status' => '', 'return_date(1i)' => '2022', 'return_date(2i)' => '9', 'return_date(3i)' => '29' }
      subject(:object) { Reservations::Update.new(admin, reservation, params) }

      it "returns 'status must be one of: 0, 1, 2, 3' error message" do
        expect(object.call).to eq [{ status: ['must be one of: 0, 1, 2, 3'] }]
      end
    end

    context "and reservation's return_date is changed to blank" do
      params = { 'status' => '1', 'return_date(1i)' => '', 'return_date(2i)' => '', 'return_date(3i)' => '' }
      subject(:object) { Reservations::Update.new(admin, reservation, params) }

      it "returns 'return date is missing' error message" do
        expect(object.call).to eq [{ return_date: ['is missing'] }]
      end
    end

    context "and params pass reservation's status and return date" do
      params = { 'status' => '1', 'return_date(1i)' => '2022', 'return_date(2i)' => '9', 'return_date(3i)' => '29' }

      it "successfully updates reservation's status" do
        Reservations::Update.new(admin, reservation, params).call

        expect(reservation.status).to eq('borrowed')
      end
    end

    context "and params pass reservation's status and return date" do
      params = { 'status' => '1', 'return_date(1i)' => '2022', 'return_date(2i)' => '9', 'return_date(3i)' => '29' }

      it "successfully updates reservation's return_date" do
        Reservations::Update.new(admin, reservation, params).call

        expect(reservation.return_date).to eq(('29-09-2022').to_datetime)
      end
    end
  end
end
