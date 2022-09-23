class BooksController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @authors = @book.authors
    if current_user
      if @book.reservations.reserved.first
        @current_reservation = @book.reservations.reserved.first
      elsif @book.reservations.borrowed.first
        @current_reservation = @book.reservations.borrowed.first
      elsif @book.reservations.lost.first
        @book_lost = true
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new
    if Books::BookCreator.call(book_params.to_h)
      redirect_to @book, notice: 'Book successfully created!'
    else
      render :new
    end
    # else
    #   puts result.errors.to_h
    # end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    contract = Books::UpdateContract.new
    result = contract.call(book_params.to_h)
    if result.success?
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to @book, notice: 'Book successfully updated!'
      else
        render :edit
      end
      # else
      #   puts result.errors.to_h
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url, alert: 'Book successfully deleted!'
  end

  private

  def book_params
    params.require(:book).permit(:title, :publisher_id, :publication_date, author_ids: [])
  end
end
