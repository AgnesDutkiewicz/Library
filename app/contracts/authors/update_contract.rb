module Authors
  class UpdateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_date).value(:date_time)
    end
  end
end
