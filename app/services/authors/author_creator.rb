module Authors
  class AuthorCreator < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      contract = Authors::UpdateContract.new
      result = contract.call(@params)
      create_author if result.success?
    end

    private

    def create_author
      Author.create(**@params)
    end
  end
end
