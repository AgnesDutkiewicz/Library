class BooksController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @authors = @book.authors
    return unless current_user

    @current_reservation = @book.reservations.reserved.first || @book.reservations.borrowed.first

    @book_lost = true if @book.reservations.lost.first
  end

  def new
    @book = Book.new
  end

  def create
    service_object = Books::Create.new(current_user, book_params.to_h)
    result = service_object.call
    if service_object.success?
      @book = result
      redirect_to @book, notice: 'Book successfully created!'
    else
      service_object.error_messages
      @book = Book.new
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    service_object = Books::Edit.new(current_user, @book, book_params.to_h)
    service_object.call
    if service_object.success?
      redirect_to @book, notice: 'Book successfully updated!'
    else
      service_object.error_messages
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
