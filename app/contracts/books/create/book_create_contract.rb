require 'dry-validation'

class BookCreateContract < Dry::Validation::Contract
  params do
    required(:title).value(:string)
    optional(:publication_date).value(:date)
    required(:author_ids).value(:array)
    required(:publisher_id).value(:integer)
  end

  rule(:title) do
    key.failure('title is required') if value.empty?
  end
end

# contract = BookCreateContract.new
# result = contract.(title: '', author_ids: ["","5"], publisher_id: 5)
# puts result.success?
# puts result.errors.to_h
