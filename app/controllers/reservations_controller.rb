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
    service_object = Reservations::Create.new(current_user, reservation_params.to_h)
    result = service_object.call
    if service_object.success?
      @reservation = result
      redirect_to user_path(current_user), notice: 'Book reserved!'
    else
      service_object.error_messages
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    service_object = Reservations::Update.new(current_user, reservation_params.to_h)
    result = service_object.call
    if service_object.success?
      @reservation = Reservation.find(params[:id])
      if @reservation.update(reservation_params)
        redirect_to book_path(@book), notice: 'Reservation Changed'
      else
        render :edit
      end
    else
      puts result.errors.to_h
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def reservation_params
    params.require(:reservation).permit(:book_id, :user_id, :return_date, :status)
  end
end
