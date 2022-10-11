module Authors
  class Update < ApplicationService
    def initialize(user, author, params)
      @user = user
      @author = author
      @params = params
      @errors = []
    end

    def call
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
      parse_date(params, 'birth_date')
    end

    def update_author
      author.update(**params)
    end
  end
end
