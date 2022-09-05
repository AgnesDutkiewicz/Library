require 'rails_helper'

RSpec.describe Publisher, type: :model do
  context 'when all attributes are given' do
    let(:publisher) { build :publisher }

    it 'creates a publisher' do
      expect(publisher.save).to eq(true)
    end
  end

  context 'when name is blank' do
    let(:publisher) { build :publisher, name: '' }

    it 'fails to create publisher' do
      publisher.valid?

      expect(publisher.errors[:name].any?).to eq(true)
    end
  end
end
