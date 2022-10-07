module Reservations
  class UpdateContract < Contract
    params do
      required(:status).value(included_in?: [0, 1, 2, 3])
      required(:return_date).value(:date_time)
    end
  end
end
