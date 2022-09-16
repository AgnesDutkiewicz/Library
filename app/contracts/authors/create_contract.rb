module Authors
  class CreateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_year).value(:integer)
    end
  end
end
