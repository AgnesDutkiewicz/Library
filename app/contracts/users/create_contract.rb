module Users
  class CreateContract < Contract
    params do
      required(:name).filled(:string)
      required(:email).filled(:string)
      required(:password).filled(:string)
    end

    rule(:email) do
      key.failure('has invalid format') unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
    end

    rule(:admin) do
      key.failure('new user cant be admin') if value == true
    end
  end
end
