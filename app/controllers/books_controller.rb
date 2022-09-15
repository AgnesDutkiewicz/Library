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
      if @book.reservations.status_reserved.first
        @current_reservation = @book.reservations.status_reserved.first
      elsif @book.reservations.status_borrowed.first
        @current_reservation = @book.reservations.status_borrowed.first
      elsif @book.reservations.status_lost.first
        @book_lost = true
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book successfully created!'
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
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
