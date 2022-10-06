require 'rails_helper'

RSpec.describe Reservations::Create, type: :model do
  describe '.call' do
    let!(:user) { create :user, admin: false }
    let!(:book) { create :book_with_author }

    context 'when user is not signed in' do
      subject(:object) { Reservations::Create.new(nil, book) }

      it "returns 'user must be present' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be present' }]
      end
    end

    context 'when user is signed in' do
      subject(:object) { Reservations::Create.new(user, book) }

      it 'successfully creates reservation' do
        reservation = Reservations::Create.new(user, book).call

        expect(reservation.book_id).to eq(book.id)
        expect(reservation.user_id).to eq(user.id)
        expect(reservation.status).to eq('reserved')
        expect(reservation.return_date).to eq(reservation.created_at + 7.days)
      end
    end
  end
end
