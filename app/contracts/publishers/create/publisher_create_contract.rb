require 'dry-validation'

class PublisherCreateContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    optional(:origin).value(:string)
  end

  rule(:name) do
    key.failure('name is required') if value.empty?
  end
end

# contract = PublisherCreateContract.new
# result = contract.(name: 'PWN', origin: 'Poland')
# puts result.success?
# puts result.errors.to_h
