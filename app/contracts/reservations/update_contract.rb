require 'dry-validation'

class UpdateContract < Dry::Validation::Contract
  params do
    required(:book_id).value(:integer)
    required(:user_id).value(:integer)
    required(:status).value(:integer)
    required(:date_of_return).value(:date)
  end
end