module Books
  class BookCreator < ApplicationService
    def initialize(params)
      @title = params[:title]
      @publication_date = params[:publication_date]
      @publisher_id = params[:publisher_id]
      @author_ids = params[:author_ids]
    end

    def call
      execute
    end

    private

    def execute
      contract = Books::UpdateContract.new
      result = contract.call(title: @title, publication_date: @publication_date, publisher_id: @publisher_id,
                             author_ids: @author_ids.map(&:to_i))
      create_book if result.success?
    end

    def create_book
      @book = Book.create!(title: @title, publication_date: @publication_date, publisher_id: @publisher_id,
                           author_ids: @author_ids.map(&:to_i))
    end
  end
end
