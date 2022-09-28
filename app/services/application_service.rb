class ApplicationService
  def self.call(*args)
    new(*args).call
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_not_admin?
    current_user && !current_user.admin?
  end
end
