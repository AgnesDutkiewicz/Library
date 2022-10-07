module Books
  class Update < ApplicationService
    def initialize(user, book, params)
      @user = user
      @book = book
      @params = params
      @errors = []
    end

    def call
      prepare_params
      contract_call = Books::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        update_book
      end
    end

    private

    attr_reader :params, :user, :book, :errors

    def prepare_params
      parse_array_ids(params, 'author_ids')
      parse_id(params, 'publisher_id')
      parse_date(params, 'publication_date')
    end

    def update_book
      book.update(**params)
    end
  end
end
