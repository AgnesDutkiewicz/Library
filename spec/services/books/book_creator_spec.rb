require 'rails_helper'

RSpec.describe Books::BookCreator, type: :model do
  describe '.call' do
    let!(:user) { create :user, admin: false }
    let!(:admin) { create :user, admin: true }
    let!(:author) { create :author }

    context 'when user is not signed in' do
      params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                 'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:object) { Books::BookCreator.new(nil, params) }

      it "returns 'user must be present' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be present' }]
      end
    end

    context 'when user is not an admin' do
      params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                 'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:object) { Books::BookCreator.new(user, params) }

      it "returns 'user must be an admin' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be an admin' }]
      end
    end

    context 'when user is admin' do
      context "and params doesn't pass book's title" do
        params = { 'author_ids' => ['', '1'], 'publisher_id' => '1',
                   'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
        subject(:object) { Books::BookCreator.new(admin, params) }

        it "returns 'title is missing' error message" do
          expect(object.call).to eq [{ title: ['is missing'] }]
        end
      end

      context "and params doesn't pass book's author_ids" do
        params = { 'title' => 'Book title', 'publisher_id' => '1',
                   'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
        subject(:object) { Books::BookCreator.new(admin, params) }

        it "returns 'author_ids is missing' error message" do
          expect(object.call).to eq [{ author_ids: ['is missing'] }]
        end
      end

      context "and params doesn't pass book's publisher_id" do
        params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publication_date(1i)' => '2022',
                   'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
        subject(:object) { Books::BookCreator.new(admin, params) }

        it "returns 'publisher_id is missing' error message" do
          expect(object.call).to eq [{ publisher_id: ['is missing'] }]
        end
      end

      context "and params doesn't pass book's publication_date" do
        params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1' }
        it 'successfully creates book' do
          book = Books::BookCreator.new(admin, params).call

          expect(book.title).to eq('Book title')
          expect(book.author_ids).to eq([1])
          expect(book.publisher_id).to eq(1)
          expect(book.publication_date).to eq(nil)
        end
      end

      context "and params pass all book's data" do
        params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                   'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }

        it 'successfully creates author' do
          book = Books::BookCreator.new(admin, params).call

          expect(book.title).to eq('Book title')
          expect(book.author_ids).to eq([1])
          expect(book.publisher_id).to eq(1)
          expect(book.publication_date).to eq('30/09/2022')
        end
      end
    end
  end
end
