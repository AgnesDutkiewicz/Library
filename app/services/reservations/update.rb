module Reservations
  class Update < ApplicationService
    def initialize(user, reservation, params)
      @user = user
      @reservation = reservation
      @params = params
      @errors = []
    end

    def call
      return unless authorized?

      prepare_params
      contract_call = Reservations::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        update_reservation
      end
    end

    private

    attr_reader :params, :user, :reservation, :errors

    def authorized?
      if user.nil? || user.admin? == false
        errors << { user: 'must be an admin' }
      else
        true
      end
    end

    def prepare_params
      params['status'] = params['status'].to_i if params['status'].present?

      if params['return_date(1i)'].present? && params['return_date(2i)'].present? && params['return_date(3i)'].present?
        params['return_date'] = DateTime.new(params['return_date(1i)'].to_i,
                                             params['return_date(2i)'].to_i,
                                             params['return_date(3i)'].to_i)
      end
    end

    def update_reservation
      reservation.update(**params)
    end
  end
end
