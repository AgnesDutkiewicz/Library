module Books
  class Create < ApplicationService
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

    private

    attr_reader :params, :user, :errors

    def prepare_params
      return params['author_ids'] = params['author_ids'][1..].map(&:to_i) if params['author_ids'].present?

      return params['publisher_id'] = params['publisher_id'].to_i if params['publisher_id'].present?

      if params['publication_date(1i)'].present? && params['publication_date(2i)'].present? &&
         params['publication_date(3i)'].present?
        params['publication_date'] = DateTime.new(params['publication_date(1i)'].to_i,
                                                  params['publication_date(2i)'].to_i,
                                                  params['publication_date(3i)'].to_i)
      end
    end

    def create_book
      Book.create(**params)
    end
  end
end