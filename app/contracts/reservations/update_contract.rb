module Reservations
  class UpdateContract < Contract
    params do
      required(:book_id).value(:integer)
      required(:user_id).value(:integer)
      required(:status).value(included_in?: [0, 1, 2, 3])
      required(:return_date).value(:date)
    end
  end
end
