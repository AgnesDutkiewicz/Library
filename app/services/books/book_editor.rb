module Books
  class BookEditor < ApplicationService
    def initialize(book, params)
      @book = book
      @title = params[:title]
      @publication_date = params[:publication_date]
      @publisher_id = params[:publisher_id]
      @author_ids = params[:author_ids]
    end

    def call
      contract = Books::UpdateContract.new
      result = contract.call(title: @title, publication_date: @publication_date, publisher_id: @publisher_id.to_i,
                             author_ids: @author_ids.map(&:to_i)[1..])
      update_book if result.success?
    end

    private

    def update_book
      @book.update(title: @title, publication_date: @publication_date, publisher_id: @publisher_id.to_i,
                  author_ids: @author_ids.map(&:to_i)[1..])
    end
  end
end
