require 'dry-validation'

class UpdateContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    required(:email).filled(:string)
    required(:password_digest).value(:string)
    required(:admin).value(:bool)
  end

  rule(:email) do
    key.failure('has invalid format') unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
  end
end
