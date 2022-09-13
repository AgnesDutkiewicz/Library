class Reservation < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates_uniqueness_of :status_up, conditions: -> { where false }
end
