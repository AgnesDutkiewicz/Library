module Authors
  class AuthorCreator < ApplicationService
    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      if user.nil?
        @errors << { user: 'must be present' }
      elsif user.admin? == false
        @errors << { user: 'must be admin' }
      else
        prepare_params
        contract = Authors::UpdateContract.new
        contract_call = contract.call(params)
        if contract_call.failure?
          @errors << contract_call.errors.to_h
        else
          create_author
        end
      end
    end

    def success?
      if @author.is_a? Author
        true
      else
        false
      end
    end

    def failure?
      if @author.is_a? Author
        false
      else
        true
      end
    end

    def error_messages
      puts @errors
    end

    private

    attr_reader :params, :user

    def prepare_params
      params[:birth_date] = DateTime.new(params['birth_date(1i)'].to_i, params['birth_date(2i)'].to_i,
                                         params['birth_date(3i)'].to_i)
    end

    def create_author
      @author = Author.create(**params)
    end
  end
end
