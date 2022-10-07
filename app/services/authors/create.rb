module Authors
  class Create < ApplicationService
    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      prepare_params
      contract_call = Authors::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        create_author
      end
    end

    private

    attr_reader :params, :user, :errors

    def prepare_params
      parse_date(params, 'birth_date')
    end

    def create_author
      Author.create(**params)
    end
  end
end
