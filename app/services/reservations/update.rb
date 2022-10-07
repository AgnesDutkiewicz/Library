module Reservations
  class Update < ApplicationService
    def initialize(user, reservation, params)
      @user = user
      @reservation = reservation
      @params = params
      @errors = []
    end

    def call
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


    def prepare_params
      status_params

      return unless date_params?

      params['return_date'] = DateTime.new(params['return_date(1i)'].to_i,
                                           params['return_date(2i)'].to_i,
                                           params['return_date(3i)'].to_i)
    end

    def status_params
      params['status'] = params['status'].to_i if params['status'].present?
    end

    def date_params?
      true if params['return_date(1i)'].present? && params['return_date(2i)'].present? &&
              params['return_date(3i)'].present?
    end

    def update_reservation
      reservation.update(**params)
    end
  end
end
