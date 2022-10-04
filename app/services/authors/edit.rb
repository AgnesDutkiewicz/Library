module Authors
  class Edit < ApplicationService
    def initialize(user, author, params)
      @user = user
      @author = author
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
        update_author
      end
    end

    private

    attr_reader :params, :user, :author, :errors

    def prepare_params
      if params['birth_date(1i)'].present? &&
         params['birth_date(2i)'].present? && params['birth_date(3i)'].present?
        params['birth_date'] = DateTime.new(params['birth_date(1i)'].to_i, params['birth_date(2i)'].to_i,
                                            params['birth_date(3i)'].to_i)
      end
    end

    def update_author
      author.update(**params)
    end
  end
end
