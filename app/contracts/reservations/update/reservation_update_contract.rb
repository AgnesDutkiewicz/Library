require 'dry-validation'

class ReservationCreateContract < Dry::Validation::Contract
  params do
    required(:book_id).value(:integer)
    required(:user_id).value(:integer)
    required(:status_up).value(:bool)
    required(:date_of_return).value(:date)
  end

  rule(:book_id) do
    key.failure('book is required') if value.empty?
  end

  rule(:user_id) do
    key.failure('user is required') if value.empty?
  end

  rule(:status_up) do
    key.failure('reservation must be active when its canceled') if value == true
  end
end

# contract = UserCreateContract.new
# result = contract.(book_id: 5, user_id: 7, status_up: false, date_of_return: '')
# puts result.success?
# puts result.errors.to_h
