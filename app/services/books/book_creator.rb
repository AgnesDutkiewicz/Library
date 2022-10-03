module Books
  class BookCreator < ApplicationService
    def initialize(user, params)
      @user = user
      @params = params
      @errors = []
    end

    def call
      return unless authorized?

      prepare_params
      contract_call = Books::UpdateContract.new.call(params)
      if contract_call.failure?
        errors << contract_call.errors.to_h
      else
        create_book
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
      return unless params['author_ids'].present?

      params['author_ids'] = params['author_ids'][1..].map(&:to_i)

      return unless params['publisher_id'].present?

      params['publisher_id'] = params['publisher_id'].to_i

      return unless params['publication_date(1i)'].present?

      params['publication_date'] =
        DateTime.new(params['publication_date(1i)'].to_i, params['publication_date(2i)'].to_i,
                     params['publication_date(3i)'].to_i)
    end

    def create_book
      Book.create(**params)
    end
  end
end
