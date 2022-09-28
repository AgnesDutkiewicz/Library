module Authors
  class AuthorCreator < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      prepare_params
      contract = Authors::UpdateContract.new
      @result = contract.call(params)
      success(@result)
    end

    def success(contract)
      if contract.success? & create_author.success?
        Success
      else
        failure
      end
    end

    def failure
      @errors = []
      if current_user
        @errors << 'Failure(:not_logged_in)'
      elsif current_user_not_admin?
        @errors << 'Failure(:access_denied)'
      elsif prepare_params.failure?
        @errors << 'Failure(:something_went_wrong)'
      elsif @result.failure?
        @errors << 'Failure(:invalid_data)'
      end
    end

    def error_messages
      puts @errors
    end

    private

    attr_reader :params

    def prepare_params
      params[:birth_date] = DateTime.new(params['birth_date(1i)'].to_i, params['birth_date(2i)'].to_i,
                                         params['birth_date(3i)'].to_i)
    end

    def create_author
      Author.create(**params)
    end
  end
end
