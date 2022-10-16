module Books
  class Create < ApplicationService
    include Dry::Monads[:result, :do]

    def initialize(params)
      @params = params
      @errors = []
    end

    def call
      prepare_params
      yield contract_call
      book = yield create_book

      Success(book)
    end

    private

    attr_reader :params, :errors

    def prepare_params
      parse_array_ids(params, 'author_ids')
      parse_id(params, 'publisher_id')
      parse_date(params, 'publication_date')
    end

    def contract_call
      contract_call = Books::UpdateContract.new.call(params)

      return Failure(contract_call.errors.to_h) if contract_call.failure?

      Success()
    end

    def create_book
      book = Book.new(**params)

      if book.save
        Success(book)
      else
        Failure(book.errors.full_messages)
      end
    end
  end
end
