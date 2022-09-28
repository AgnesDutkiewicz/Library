module Authors
  class AuthorEditor < ApplicationService
    def initialize(author, params)
      @author = author
      @params = params
    end

    def call
      prepare_params
      contract = Authors::UpdateContract.new
      result = contract.call(@params)
      if result.success?
        update_author
      else
        @errors = []
        @errors << result.errors.to_h
      end
    end

    private

    def prepare_params
      @params[:birth_date] = DateTime.new(@params["birth_date(1i)"].to_i, @params["birth_date(2i)"].to_i, @params["birth_date(3i)"].to_i)
    end

    def update_author
      @author.update(**@params)
    end
  end
end
