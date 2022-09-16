class Reservation < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum status: {
    reserved: 0,
    borrowed: 1,
    returned: 2,
    lost: 3
  }, _prefix: true

  def booking_duration
    7
  end

  def return_date
    created_at + booking_duration.days
  end
end
