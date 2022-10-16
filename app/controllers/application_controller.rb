class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Dry::Monads[:result, :do]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def prepare_create_response(service_object, notice)
    result = service_object.call
    case result
    when Success
      redirect_to returned_object(result), notice: notice
    when Failure
      flash.now[:error] = render_error_message(result.failure)
      render :new
    else
      flash.now[:error] = result.failure.to_s
    end
  end

  def returned_object(result)
    yield result
  end

  def prepare_update_response(object, service_object, notice)
    service_object.call
    if service_object.success?
      redirect_to object, notice: notice
    else
      service_object.error_messages
      render :edit
    end
  end

  def render_error_message(result)
    result.flatten.map { |data_name, errors| "#{data_name} #{errors}" }.join(' ')
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def require_sign_in
    return if current_user

    session[:intended_url] = request.url
    redirect_to new_session_url, alert: 'Please sign in first!'
  end

  def require_admin
    redirect_to root_url, alert: 'Unauthorized access!' unless current_user_admin?
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def current_user_admin?
    current_user&.admin?
  end

  helper_method :current_user_admin?
end
