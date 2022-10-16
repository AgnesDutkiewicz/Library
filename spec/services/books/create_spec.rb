require 'rails_helper'

RSpec.describe Books::Create, type: :model do
  describe '.call' do
    let!(:author) { create :author }
    let!(:publisher) { create :publisher }

    context "and params doesn't pass book's title" do
      params = { 'author_ids' => ['', '1'], 'publisher_id' => '1',
                 'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:service_call) { Books::Create.new(params).call }
      it "returns 'title is missing' error message" do
        expect(service_call).not_to be_success
        expect(service_call.failure).to eq({ title: ['is missing'] })
      end
    end

    context "and params doesn't pass book's author_ids" do
      params = { 'title' => 'Book title', 'publisher_id' => '1',
                 'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:service_call) { Books::Create.new(params).call }
      it "returns 'author_ids is missing' error message" do
        expect(service_call).not_to be_success
        expect(service_call.failure).to eq({ author_ids: ['is missing'] })
      end
    end

    context "and params doesn't pass book's publisher_id" do
      params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publication_date(1i)' => '2022',
                 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:service_call) { Books::Create.new(params).call }
      it "returns 'publisher_id is missing' error message" do
        expect(service_call).not_to be_success
        expect(service_call.failure).to eq({ publisher_id: ['is missing'] })
      end
    end

    context "and params doesn't pass book's publication_date" do
      params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1' }
      subject(:service_call) { Books::Create.new(params).call }
      it 'successfully creates book' do
        book = service_call.value!

        expect(service_call).to be_success
        expect(book.title).to eq('Book title')
        expect(book.author_ids).to eq([1])
        expect(book.publisher_id).to eq(1)
        expect(book.publication_date).to eq(nil)
      end
    end

    context "and params pass all book's data" do
      params = { 'title' => 'Book title', 'author_ids' => ['', '1'], 'publisher_id' => '1',
                 'publication_date(1i)' => '2022', 'publication_date(2i)' => '9', 'publication_date(3i)' => '30' }
      subject(:service_call) { Books::Create.new(params).call }
      it 'successfully creates book' do
        book = service_call.value!

        expect(service_call).to be_success
        expect(book.title).to eq('Book title')
        expect(book.author_ids).to eq([1])
        expect(book.publisher_id).to eq(1)
        expect(book.publication_date).to eq('30/09/2022')
      end
    end
  end
end
