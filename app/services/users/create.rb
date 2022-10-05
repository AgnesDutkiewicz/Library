module Users
  class Create < ApplicationService
    def initialize(params)
      @params = params
      @errors = []
    end

    def call
      contract_call = Users::CreateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        create_user
      end
    end

    private

    attr_reader :params, :errors

    def create_author
      User.create(**params)
    end
  end
end
