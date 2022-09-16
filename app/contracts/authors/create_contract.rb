module Authors
  class CreateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_date).value(:date)
    end
  end
end
