require 'dry-validation'

module Reservations
  class CreateContract < Dry::Validation::Contract
    params do
      required(:book_id).value(:integer)
      required(:user_id).value(:integer)
      required(:status).value(included_in?: [0, 1, 2, 3])
      required(:date_of_return).value(:date)
    end
  end
end
