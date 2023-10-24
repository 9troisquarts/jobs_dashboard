require 'jobs_dashboard/storage'

module JobsDashboard::Worker
  include JobsDashboard::Storage

  class Stopped < StandardError
  end


  def set_job_parameter(param_name, value)
    begin
      store_for_id(jid, { "#{param_name}": value })
    rescue ActiveModel::UnknownAttributeError
    end
  end

  def add_job_log_line(value)
    add_log_for_id(jid, value)
  end

  def add_job_metadata(key, value)
    add_metadata_for_id(jid, key, value)
  end

end
