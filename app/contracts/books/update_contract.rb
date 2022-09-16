require 'dry-validation'

module Books
  class UpdateContract < Dry::Validation::Contract
    params do
      required(:title).filled(:string)
      optional(:publication_date).value(:date)
      required(:author_ids).filled(:array)
      required(:publisher_id).value(:integer)
    end
  end
end
