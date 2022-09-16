require 'dry-validation'

  class CreateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_year).value(:integer)
    end
  end

# contract = Authors::CreateContract.new
# result = contract.call(name: 'Agnes', birth_year: 1993)
# puts result.success?
# puts result.errors.to_h
