module Authors
  class AuthorCreator < ApplicationService
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

    def success?
      !failure?
    end

    def failure?
      errors.present?
    end

    def error_messages
      errors
    end

    private

    attr_reader :params, :user, :errors

    def authorized?
      if user.nil?
        errors << { user: 'must be present' }
      elsif user.admin? == false
        errors << { user: 'must be an admin' }
      else
        true
      end
    end

    def prepare_params
      return unless params['birth_date(1i)'].present?

      params[:birth_date] = DateTime.new(params['birth_date(1i)'].to_i, params['birth_date(2i)'].to_i,
                                         params['birth_date(3i)'].to_i)
    end

    def create_author
      Author.create(**params)
    end
  end
end
