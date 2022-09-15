require 'dry-validation'

class UpdateContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    optional(:origin).value(:string)
  end
end
