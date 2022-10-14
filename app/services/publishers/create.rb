module Publishers
  class Create < ApplicationService
    include Dry::Monads[:result, :do]

    def initialize(params)
      @params = params
      @errors = []
    end

    def call
      yield contract_call
      publisher = yield create_publisher

      Success(publisher)
    end

    private

    attr_reader :params, :errors

    def contract_call
      contract_call = Publishers::UpdateContract.new.call(params)

      return Failure(contract_call.errors.to_h) if contract_call.failure?

      Success()
    end

    def create_publisher
      publisher = Publisher.new(**params)

      if publisher.save
        Success(publisher)
      else
        Failure(:publisher_save_error)
      end
    end
  end
end
