module Books
  class UpdateContract < Contract
    params do
      required(:title).filled(:string)
      optional(:publication_date).filled(:date_time)
      required(:author_ids).filled(:array).array(type?: Integer)
      required(:publisher_id).value(:integer)
    end
  end
end
