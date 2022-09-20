module Reservations
  class CreateContract < Contract
    params do
      required(:book_id).value(:integer)
      required(:user_id).value(:integer)
      required(:status).value(included_in?: [0, 1, 2])
      required(:date_of_return).value(:date)
    end
  end
end
