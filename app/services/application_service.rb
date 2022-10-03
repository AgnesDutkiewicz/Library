class ApplicationService
  def success?
    !failure?
  end

  def failure?
    errors.present?
  end

  def error_messages
    errors
  end

  private


  def authorized?
    if user.nil?
      errors << { user: 'must be present' }
    elsif user.admin? == false
      errors << { user: 'must be an admin' }
    else
      true
    end
  end
end
