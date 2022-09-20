class User < ApplicationRecord
  has_secure_password
  has_many :reservations
  has_many :reserved_books, through: :reservations, source: :book
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end
end
