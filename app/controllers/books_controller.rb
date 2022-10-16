class BooksController < ApplicationController
  def index
    @books = policy_scope(Book)
    authorize @books
  end

  def show
    @book = policy_scope(Book).find(params[:id])
    authorize @book
    @authors = @book.authors
    return unless current_user

    @current_reservation = @book.reservations.reserved.first || @book.reservations.borrowed.first
    @book_lost = true if @book.reservations.lost.first
  end

  def new
    @book = Book.new
    authorize @book
  end

  def create
    @book = Book.new
    authorize @book
    prepare_create_response(Books::Create.new(book_params.to_h), 'Book successfully created!')
  end

  def edit
    @book = Book.find(params[:id])
    authorize @book
  end

  def update
    @book = Book.find(params[:id])
    authorize @book
    prepare_update_response(@book, Books::Update.new(current_user, @book, book_params.to_h),
                            'Book successfully updated!')
  end

  def destroy
    @book = Book.find(params[:id])
    authorize @book
    @book.destroy
    redirect_to books_url, alert: 'Book successfully deleted!'
  end

  private

  def book_params
    params.require(:book).permit(:title, :publisher_id, :publication_date, :category, author_ids: [])
  end
end
