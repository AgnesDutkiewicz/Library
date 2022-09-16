module Books
  class UpdateContract < Contract
    params do
      required(:title).filled(:string)
      optional(:publication_date).value(:date)
      required(:author_ids).filled(:array)
      required(:publisher_id).value(:integer)
    end
  end
end
