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

  def parse_id(params, id_name)
    params[id_name] = params[id_name].to_i if params[id_name].present?
  end

  def parse_array_ids(params, ids_name)
    params[ids_name] = params[ids_name][1..].map(&:to_i) if params[ids_name].present?
  end

  def parse_date(params, date_name)
    year = params["#{date_name}(1i)"].to_i
    month = params["#{date_name}(2i)"].to_i
    day = params["#{date_name}(3i)"].to_i
    params["#{date_name}"] = DateTime.new(year + month + day) if !year.zero? && !month.zero? && !day.zero?
  end
end
