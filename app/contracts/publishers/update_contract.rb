require 'dry-validation'

module Publishers
  class UpdateContract < Dry::Validation::Contract
    params do
      required(:name).filled(:string)
      optional(:origin).value(:string)
    end
  end
end
