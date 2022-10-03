module Publishers
  class PublisherCreator < ApplicationService
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

    def create_publisher
      Publisher.create(**params)
    end
  end
end
