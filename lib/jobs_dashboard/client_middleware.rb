require 'sidekiq/api'
require 'jobs_dashboard/storage'

module JobsDashboard
# Should be in the client middleware chain
  class ClientMiddleware
    include Storage

    # Parameterized initialization, use it when adding middleware to client chain
    # chain.add JobsDashboard::ClientMiddleware
    # @param [Hash] opts middleware initialization options
    # @option opts [Fixnum] :expiration ttl for complete jobs
    def initialize(opts = {})
      @expiration = opts[:expiration]
    end

    # Uses msg['jid'] id and puts :queued status in the job's Redis hash
    # @param [Class] worker_class if includes JobsDashboard::Worker, the job gets processed with the plugin
    # @param [Array] msg job arguments
    # @param [String] queue the queue's name
    # @param [ConnectionPool] redis_pool optional redis connection pool
    def call(worker, msg, queue, redis_pool=nil)
      unless get_jobs_dashboard_options(msg)[:skip]
        store_for_id(msg['jid'], {
          item_type: msg['class'],
          retry: msg['retry'],
          queue: msg['queue'],
          args: msg['args'],
          status: 'queued'
        })
      end

      yield

    end

    private
      def get_jobs_dashboard_options(msg)
        klass = msg["args"][0]["job_class"] || msg["class"] rescue msg["class"]
        job_class = klass.is_a?(Class) ? klass : Module.const_get(klass)
        job_class.get_sidekiq_options['jobs_dashboard'] || {}
      end

  end

  # Helper method to easily configure sidekiq-status client middleware
  # whatever the Sidekiq version is.
  # @param [Sidekiq] sidekiq_config the Sidekiq config
  # @param [Hash] client_middleware_options client middleware initialization options
  # @option client_middleware_options [Fixnum] :expiration ttl for complete jobs
  def self.configure_client_middleware(sidekiq_config, client_middleware_options = {})
    sidekiq_config.client_middleware do |chain|
      chain.add JobsDashboard::ClientMiddleware, client_middleware_options
    end
  end
end
