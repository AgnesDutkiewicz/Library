class Book < ApplicationRecord
  belongs_to :publisher
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reservations
  has_many :users, through: :reservations

  CATEGORIES = %w[3+ 7+ 10+ 15+ 18+].freeze

  validates :category, inclusion: {
    in: CATEGORIES,
    message: 'must be one of available categories'
  }
end
