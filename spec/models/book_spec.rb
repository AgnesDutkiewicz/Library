require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'when all attributes are given' do
    let(:book) { build :book_with_author }

    it 'creates a book' do
      expect(book.save).to eq(true)
    end
  end

  context 'when title is blank' do
    let(:book) { build :book_with_author, title: '' }

    it 'fails to create book' do
      book.valid?

      expect(book.errors[:title].any?).to eq(true)
    end
  end

  context 'when author is blank' do
    let(:book) { build :book }

    it 'fails to create book' do
      book.valid?

      expect(book.save).to eq(false)
    end
  end
end
