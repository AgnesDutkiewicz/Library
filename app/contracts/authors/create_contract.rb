require 'dry-validation'

module Authors
  class CreateContract < Dry::Validation::Contract
end
  params do
    required(:name).filled(:string)
    optional(:birth_year).value(:integer)
  end
end
