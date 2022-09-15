require 'dry-validation'

class CreateContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    optional(:birth_year).value(:integer)
  end
end
