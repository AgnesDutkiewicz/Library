module Publishers
  class PublisherEditor < ApplicationService
    def initialize(user, publisher, params)
      @user = user
      @publisher = publisher
      @params = params
      @errors = []
    end

    def call
      return unless authorized?

      contract_call = Publishers::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        update_publisher
      end
    end

    private

    attr_reader :params, :user, :publisher, :errors

    def update_publisher
      publisher.update(**params)
    end
  end
end
