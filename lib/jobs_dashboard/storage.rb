module JobsDashboard::Storage

  protected

  # Stores job log in database
  # sets last update time
  # @param [String] id job id
  # @param [Hash] status_updates updated values
  # @param [Integer] expiration optional expire time in seconds
  def store_for_id(id, attributes = nil)
    begin
      ActiveRecord::Base.connection_pool.with_connection do
        @job_log = JobsDashboard::JobLog.find_or_initialize_by sidekiq_jid: id
        @job_log.attributes = attributes if attributes
        @job_log.save
      end
    ensure
      ActiveRecord::Base.clear_active_connections!
    end
  end

  def update_job_status(id, status)
    store_for_id(id, { status: status })
  end

end
