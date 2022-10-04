require 'rails_helper'

RSpec.describe Books::Edit, type: :model do
  describe '.call' do
    let!(:user) { create :user, admin: false }
    let!(:admin) { create :user, admin: true }
    let!(:book) { create :book_with_author }

    context 'when user is not signed in' do
      params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                 'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:object) { Books::Edit.new(nil, book, params) }

      it "returns 'user must be present' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be present' }]
      end
    end

    context 'when user is not an admin' do
      params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                 'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:object) { Books::Edit.new(user, book, params) }

      it "returns 'user must be an admin' error message" do
        object.call

        expect(object.error_messages).to eq [{ user: 'must be an admin' }]
      end
    end

    context 'when user is admin' do
      context "and book's title is changed to blank" do
        params = { 'title' => '', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                   'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
        subject(:object) { Books::Edit.new(admin, book, params) }

        it "returns 'title must be filled' error message" do
          expect(object.call).to eq [{ title: ['must be filled'] }]
        end
      end

      context "and book's author_ids is changed to blank" do
        params = { 'title' => 'Book title', 'author_ids' => [''], 'publisher_id' => '1',
                   'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
        subject(:object) { Books::Edit.new(admin, book, params) }

        it "returns 'author_ids must be filled' error message" do
          expect(object.call).to eq [{ author_ids: ['must be filled'] }]
        end
      end

      context "and book's publisher_id is changed to '' " do
        params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '',
                   'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
        subject(:object) { Books::Edit.new(admin, book, params) }

        it "returns 'publisher_id must be an integer' error message" do
          expect(object.call).to eq [{ publisher_id: ['must be an integer'] }]
        end
      end

      context "and book's publication_date is changed to blank" do
        params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                   'publication_date(1i)' => '', 'publication_date(2i)' => '', 'publication_date(3i)' => '' }
        it "successfully updates book's publication_date" do
          Books::Edit.new(admin, book, params).call

          expect(book.title).to eq('Book title')
          expect(book.author_ids).to eq([1])
          expect(book.publisher_id).to eq(1)
          expect(book.publication_date).to eq(nil)
        end
      end

      context "and params pass all book's data" do
        params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                   'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }

        it 'successfully updates book' do
          Books::Edit.new(admin, book, params).call

          expect(book.title).to eq('Book title')
          expect(book.author_ids).to eq([1])
          expect(book.publisher_id).to eq(1)
          expect(book.publication_date).to eq('30/09/2022')
        end
      end
    end
  end
end
