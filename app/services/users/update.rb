module Users
  class Update < ApplicationService
    def initialize(current_user, user, params)
      @current_user = current_user
      @user = user
      @params = params
      @errors = []
    end

    def call
      return unless authorized?

      prepare_params
      contract_call = Users::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        update_user
      end
    end

    private

    attr_reader :params, :current_user, :user, :errors

    def authorized?
      if user.nil?
        errors << { user: 'must be present' }
      elsif current_user == !user || user.admin? == false
        errors << { user: 'cant update another user' }
      else
        true
      end
    end

    def update_user
      user.update(**params)
    end
  end
end
