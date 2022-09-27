module Books
  class BookEditor < ApplicationService
    def initialize(book, params)
      @book = book
      @params = params
    end

    def call
      prepare_params
      contract = Books::UpdateContract.new
      result = contract.call(@params)
      update_book if result.success?
    end

    private

    def prepare_params
      @params[:publication_date] = DateTime.new(@params["publication_date(1i)"].to_i, @params["publication_date(2i)"].to_i, @params["publication_date(3i)"].to_i)
      @params[:publisher_id] = @params[:publisher_id].to_i
      @params[:author_ids] = @params[:author_ids].map(&:to_i)[1..]
    end

    def update_book
      @book.update(@params)
    end
  end
end
