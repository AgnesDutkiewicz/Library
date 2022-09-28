module Authors
  class UpdateContract < Contract
    params do
      required(:name).filled(:string)
      optional(:birth_date).maybe(:date_time)
    end
  end
end
