module Publishers
  class Create < ApplicationService
    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      return unless authorized?

      contract_call = Publishers::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        create_publisher
      end
    end

    private

    attr_reader :params, :user, :errors

    def create_publisher
      Publisher.create(**params)
    end
  end
end
