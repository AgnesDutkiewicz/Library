require 'dry/monads'

module Authors
  class Create < ApplicationService
    include Dry::Monads[:result, :do]

    def initialize(params)
      @params = params
      @errors = []
    end

    def call
      prepare_params
      yield contract_call
      author = yield create_author

      Success(author)
    end

    private

    attr_reader :params, :errors

    def prepare_params
      parse_date(params, 'birth_date')
    end

    def contract_call
      contract_call = Authors::UpdateContract.new.call(params)

      return Failure(contract_call.errors.to_h) if contract_call.failure?

      Success()
    end

    def create_author
      author = Author.new(**params)

      if author.save
        Success(author)
      else
        Failure(:author_save_error)
      end
    end
  end
end
