class Reservation < ApplicationRecord
  belongs_to :book
  belongs_to :user
  after_create :set_defaults

  DEFAULT_BOOKING_DURATION = 7

  enum status: {
    reserved: 0,
    borrowed: 1,
    returned: 2,
    lost: 3
  }

  def set_defaults
    self.return_date ||= self.created_at + DEFAULT_BOOKING_DURATION.days
  end
end
