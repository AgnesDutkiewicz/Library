require 'dry-validation'

module Users
  class CreateContract < Dry::Validation::Contract
    params do
      required(:name).filled(:string)
      required(:email).filled(:string)
      required(:password_digest).filled(:string)
      required(:admin).value(:false)
    end

    rule(:email) do
      key.failure('has invalid format') unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
    end
  end
end