require 'dry-validation'

class UpdateContract < Dry::Validation::Contract
  params do
    required(:title).value(:string)
    optional(:publication_date).value(:date)
    required(:author_ids).value(:array)
    required(:publisher_id).value(:integer)
  end
end
