require 'dry-validation'

class PublisherUpdateContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    optional(:origin).value(:string)
  end

  rule(:name) do
    key.failure('name is required') if value.empty?
  end
end

# contract = PublisherUpdateContract.new
# result = contract.(name: 'PWN', origin: 'Poland')
# puts result.success?
# puts result.errors.to_h
