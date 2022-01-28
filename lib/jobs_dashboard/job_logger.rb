require 'sidekiq/job_logger'

module JobsDashboard
  class JobLogger < Sidekiq::JobLogger
    def call(item, queue)
      start = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC)
      @logger.info("start")

      begin
        ActiveRecord::Base.connection_pool.with_connection do
          @job_log = JobsDashboard::JobLog.create!(
            sidekiq_jid: item['jid'],
            status: 'queued',
            item_type: item['class'],
            args: item['args'],
            retry: item['retry'],
            queue: item['queue']
          )
        end
      ensure
        ActiveRecord::Base.clear_active_connections!
      end

      yield

      with_elapsed_time_context(start) do
        @logger.info("done")
        begin
          ActiveRecord::Base.connection_pool.with_connection do
            @job_log.update(status: 'complete', finished_at: Time.now) if @job_log
          end
        ensure
          ActiveRecord::Base.clear_active_connections!
        end
      end
    rescue Exception => e
      with_elapsed_time_context(start) do
        @logger.info("fail")
        begin
          ActiveRecord::Base.connection_pool.with_connection do
            @job_log.update(status: 'failed', finished_at: Time.now, backtrace: ([e.message] + e.backtrace)) if @job_log
          end
        ensure
          ActiveRecord::Base.clear_active_connections!
        end
      end

      raise
    end
  end
end