require 'dry-validation'

class CreateContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    optional(:birth_year).value(:integer)
  end
end
