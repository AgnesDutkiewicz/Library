class Book < ApplicationRecord
  belongs_to :publisher
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reservations
  has_many :users, through: :reservations

  validates :title, :authors, presence: true
end
