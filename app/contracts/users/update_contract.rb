module Users
  class UpdateContract < Contract
    params do
      required(:name).filled(:string)
      required(:email).filled(:string)
      required(:password_digest).filled(:string)
      required(:user)
    end

    rule(:email) do
      key.failure('has invalid format') unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
    end

    rule(:admin) do
      key.failure('only admin can make new admin') if user.admin? == false
    end
  end
end
