module Authors
  class UpdateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_year).value(:integer)
    end
  end
end
