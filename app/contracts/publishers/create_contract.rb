require 'dry-validation'

module Publishers
  class CreateContract < Dry::Validation::Contract
    params do
      required(:name).filled(:string)
      optional(:origin).value(:string)
    end
  end
end
