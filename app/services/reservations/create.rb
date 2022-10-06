module Reservations
  class Create < ApplicationService
    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      return unless authorized?

      prepare_params
      contract_call = Reservations::CreateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        create_reservation
      end
    end

    private

    attr_reader :params, :user, :errors

    def authorized?
      if user.nil?
        errors << { user: 'must be present' }
      else
        true
      end
    end

    def prepare_params
      params['user_id'] = user.id

      return params['book_id'] = params['book_id'].to_i if params['book_id'].present?

      params['status'] = params['status'].map(&:to_i) if params['user_id'].present?
    end

    def create_reservation
      Reservation.create(**params)
    end
  end
end
