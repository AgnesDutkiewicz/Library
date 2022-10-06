module Authors
  class Create < ApplicationService
    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      return unless authorized?

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
      return unless params?

      params['birth_date'] = DateTime.new(params['birth_date(1i)'].to_i, params['birth_date(2i)'].to_i,
                                          params['birth_date(3i)'].to_i)
    end

    def params?
      if params['birth_date(1i)'].present? && params['birth_date(2i)'].present? && params['birth_date(3i)'].present?
        true
      end
    end

    def create_author
      Author.create(**params)
    end
  end
end
