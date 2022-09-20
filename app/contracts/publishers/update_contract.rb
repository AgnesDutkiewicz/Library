module Publishers
  class UpdateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:origin).filled(:string)
    end
  end
end
