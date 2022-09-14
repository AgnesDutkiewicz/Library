require 'dry-validation'

class UserUpdateContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    required(:email).filled(:string)
    required(:password_digest).value(:string)
    required(:admin).value(:bool)
  end

  rule(:name) do
    key.failure('name is required') if value.empty?
  end

  rule(:email) do
    key.failure('has invalid format') unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
  end
end

# contract = UserCreateContract.new
# result = contract.(name: 'Agnes', email: 'agnes@example.com', password_digest: 'asbdakhvcaszdgncsh', admin: false)
# puts result.success?
# puts result.errors.to_h
