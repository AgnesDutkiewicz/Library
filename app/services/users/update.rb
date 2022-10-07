module Users
  class Update < ApplicationService
    def initialize(current_user, user, params)
      @current_user = current_user
      @user = user
      @params = params
      @errors = []
    end

    def call
      contract_call = Users::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        update_user
      end
    end

    private

    attr_reader :params, :current_user, :user, :errors

    def update_user
      user.update(**params)
    end
  end
end
