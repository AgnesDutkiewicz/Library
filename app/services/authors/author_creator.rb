module Authors
  class AuthorCreator < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      prepare_params
      contract = Authors::UpdateContract.new
      result = contract.call(@params)
      if result.success?
        create_author
      else
        @errors = []
        @errors << result.errors.to_h
      end
    end

    private

    def prepare_params
      @params[:birth_date] = DateTime.new(@params["birth_date(1i)"].to_i, @params["birth_date(2i)"].to_i, @params["birth_date(3i)"].to_i)
    end

    def create_author
      Author.create(**@params)
    end
  end
end
