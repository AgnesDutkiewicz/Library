module Authors
  class UpdateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_date).value(:date)
    end
  end
end
