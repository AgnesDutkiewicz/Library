class Book < ApplicationRecord
  belongs_to :publisher

  validates :title, :author, presence: true
end
