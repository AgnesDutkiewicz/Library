require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'when all attributes are given' do
    let(:author) { build :author }

    it 'successfully creates an author' do
      expect(author.save).to eq(true)
    end
  end

  context 'when name is blank' do
    let(:author) { build :author, name: '' }

    it 'fails to create an author' do
      author.valid?

      expect(author.errors[:name].any?).to eq(true)
    end
  end
end
