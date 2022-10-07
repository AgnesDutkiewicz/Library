module Books
  class Create < ApplicationService
    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      prepare_params
      contract_call = Books::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        create_book
      end
    end

    private

    attr_reader :params, :user, :errors

    def prepare_params
      parse_array_ids(params, 'author_ids')
      parse_id(params, 'publisher_id')
      parse_date(params, 'publication_date')
    end

    def create_book
      Book.create(**params)
    end
  end
end
