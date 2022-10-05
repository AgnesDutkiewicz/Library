class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations.reserved
    @borrowed_books = @user.reservations.borrowed
    @lost_books = @user.reservations.lost
  end

  def new
    @user = User.new
  end

  def create
    contract = Users::CreateContract.new
    result = contract.call(user_params.to_h)
    if result.success?
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user, notice: 'Thanks for signing up!'
      else
        render :new
      end
    else
      result.errors.to_h
    end
  end

  def edit; end

  def update
    contract = Users::UpdateContract.new
    result = contract.call(user_params.to_h)
    if result.success?
      if @user.update(user_params)
        redirect_to @user, notice: 'Account successfully updated!'
      else
        render :edit
      end
    else
      puts result.errors.to_h
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, alert: 'Account successfully deleted!'
  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
