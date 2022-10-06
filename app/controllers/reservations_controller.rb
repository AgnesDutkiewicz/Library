class ReservationsController < ApplicationController
  before_action :require_sign_in
  before_action :require_admin, except: [:create]
  before_action :set_book, except: [:index, :show]

  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    # @book.reservations.new
    service_object = Reservations::Create.new(current_user, @book)
    result = service_object.call
    if service_object.success?
      @reservation = result
      redirect_to user_path(current_user), notice: 'Book reserved!'
    else
      puts service_object.error_messages
      redirect_to @book, notice: "Something went wrong, book isn't reserved!"
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    service_object = Reservations::Update.new(current_user, @reservation, reservation_params.to_h)
    result = service_object.call
    if service_object.success?
      @reservation = result
      redirect_to book_path(@book), notice: 'Reservation Changed'
    else
      puts service_object.error_messages
      render :edit
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def reservation_params
    params.require(:reservation).permit(:status, :return_date)
  end
end
