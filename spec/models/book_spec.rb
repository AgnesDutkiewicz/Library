require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'creates a book when all attributes are given' do
    book = Book.new(book_attributes)

    expect(book.save).to eq(true)
  end

  it 'requires a title' do
    book = Book.new(title: '')

    book.valid?

    expect(book.errors[:title].any?).to eq(true)
  end

  it 'requires an author' do
    book = Book.new(author: '')

    book.valid?

    expect(book.errors[:author].any?).to eq(true)
  end
end
