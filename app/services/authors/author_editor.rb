module Authors
  class AuthorEditor < ApplicationService
    def initialize(author, params)
      @author = author
      @params = params
    end

    def call
      contract = Authors::UpdateContract.new
      result = contract.call(@params)
      update_author if result.success?
    end

    private

    def update_author
      Author.update(**@params)
    end
  end
end
