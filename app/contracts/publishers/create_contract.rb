module Publishers
  class CreateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:origin).value(:string)
    end
  end
end
