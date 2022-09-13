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
    @book.reservations.create!(user: current_user)
    redirect_to user_path(current_user), notice: 'Book reserved!'
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.status_up = false
    reservation.save
    redirect_to @book, notice: 'Reservation Canceled'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
