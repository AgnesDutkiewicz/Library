class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    @reservations = @user.reservations.reserved
    @borrowed_books = @user.reservations.borrowed
    @lost_books = @user.reservations.lost
  end

  def new
    @user = User.new
  end

  def create
    service_object = Users::Create.new(user_params.to_h)
    result = service_object.call
    if service_object.success?
      @user = result
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      puts service_object.error_messages
      @user = User.new
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    service_object = Users::Update.new(current_user, @user, user_params.to_h)
    service_object.call
    puts service_object.success?
    if service_object.success?
      redirect_to @user, notice: 'Account successfully updated!'
    else
      puts service_object.error_messages
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, alert: 'Account successfully deleted!'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
