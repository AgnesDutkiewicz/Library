require 'dry-validation'

class AuthorCreateContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    optional(:birth_year).value(:integer)
  end

  rule(:name) do
    key.failure('name is required') if value.empty?
  end
end

# contract = AuthorCreateContract.new
# result = contract.(name: 'John Tolkien', birth_year: 1951)
# puts result.success?
# puts result.errors.to_h
