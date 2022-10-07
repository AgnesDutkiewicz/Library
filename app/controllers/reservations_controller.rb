class ReservationsController < ApplicationController
  before_action :set_book, except: [:index, :show]

  def index
    @reservations = policy_scope(Reservation)
    authorize @reservations
  end

  def show
    @reservation = policy_scope(Reservation).first
    authorize @reservation
  end

  def create
    @reservation = @book.reservations.new
    authorize @reservation
    service_object = Reservations::Create.new(current_user, @book)
    result = service_object.call
    if service_object.success?
      @reservation = result
      redirect_to user_path(current_user), notice: 'Book reserved!'
    else
      service_object.error_messages
      redirect_to @book, notice: "Something went wrong, book isn't reserved!"
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    authorize @reservation
  end

  def update
    @reservation = Reservation.find(params[:id])
    authorize @reservation
    prepare_update_response(@reservation, Reservations::Update.new(current_user, @reservation, reservation_params.to_h),
                            'Reservation Changed')
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def reservation_params
    params.require(:reservation).permit(:status, :return_date)
  end
end
