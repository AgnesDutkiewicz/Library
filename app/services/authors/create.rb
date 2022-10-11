require 'dry/monads'
require 'dry/matcher/result_matcher'

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
      yield create_author
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
      author = Author.create(**params)
      Success(author)
    end
  end
end
