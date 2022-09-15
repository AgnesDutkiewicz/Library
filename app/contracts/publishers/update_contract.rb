require 'dry-validation'

class UpdateContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    optional(:origin).value(:string)
  end
end
