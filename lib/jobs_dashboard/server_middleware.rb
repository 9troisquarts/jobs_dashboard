require 'jobs_dashboard/storage'
module JobsDashboard
  class ServerMiddleware

    include JobsDashboard::Storage

    # Options can be send in sidekiq.rb initializer
    # @param [Hash] opts middleware initialization options
    # @option opts
    def initialize(opts = {})
    end

    # Uses sidekiq's internal jid as id
    # Store worker status in DB
    # @param [Worker] worker worker instance
    # @param [Array] msg job args, should have jid format
    # @param [String] queue name
    def call(worker, msg, queue)
      # Determine the actual job class
      # Bypass if attributes skip is set
      if get_jobs_dashboard_options(worker)[:skip]
        yield
        return
      end

      update_job_status worker.jid, 'working'
      yield
      update_job_status worker.jid, 'complete'
    #rescue Worker::Stopped
    # update_job_status worker.jid, 'stopped'
    rescue SystemExit, Interrupt
      update_job_status worker.jid, 'interrupted'
      raise
    rescue Exception
      status = :failed
      update_job_status worker.jid, 'failed'
      raise
    end

    private
      def get_jobs_dashboard_options(worker)
        worker.class.get_sidekiq_options['jobs_dashboard'] || {}
      end

  end

  # Helper method to easily configure sidekiq-status server middleware
  # whatever the Sidekiq version is.
  # @param [Sidekiq] sidekiq_config the Sidekiq config
  # @param [Hash] server_middleware_options server middleware initialization options
  # @option server_middleware_options
  def self.configure_server_middleware(sidekiq_config, server_middleware_options = {})
    sidekiq_config.server_middleware do |chain|
      chain.add JobsDashboard::ServerMiddleware, server_middleware_options
    end

  end
end
