module Authors
  class UpdateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_date).filled(:date_time)
    end
  end
end
