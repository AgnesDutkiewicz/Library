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
    @book = Books::BookCreator.call(book_params.to_h)

    if @book
      redirect_to @book, notice: 'Book successfully created!'
    else
      @book = Book.new
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    Books::BookEditor.call(@book, book_params.to_h)

    if @book
      redirect_to @book, notice: 'Book successfully updated!'
    else
      render :edit
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
