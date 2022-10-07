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
end
