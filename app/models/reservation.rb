class Reservation < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates_uniqueness_of :status_up, conditions: -> { where false }

  def booking_duration
    7
  end

  def date_of_return
    created_at + booking_duration.days
  end
end
