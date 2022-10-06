module Books
  class Update < ApplicationService
    def initialize(user, book, params)
      @user = user
      @book = book
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
        update_book
      end
    end

    private

    attr_reader :params, :user, :book, :errors

    def prepare_params
      author_params
      publisher_params
      return unless date_params?

      params['publication_date'] = DateTime.new(params['publication_date(1i)'].to_i,
                                                params['publication_date(2i)'].to_i,
                                                params['publication_date(3i)'].to_i)
    end

    def author_params
      params['author_ids'] = params['author_ids'][1..].map(&:to_i) if params['author_ids'].present?
    end

    def publisher_params
      params['publisher_id'] = params['publisher_id'].to_i if params['publisher_id'].present?
    end

    def date_params?
      if params['publication_date(1i)'].present? && params['publication_date(2i)'].present? &&
         params['publication_date(3i)'].present?
        true
      end
    end

    def update_book
      book.update(**params)
    end
  end
end
