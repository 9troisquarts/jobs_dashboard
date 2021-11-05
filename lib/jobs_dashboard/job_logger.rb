require 'sidekiq/job_logger'

module JobsDashboard
  class JobLogger < Sidekiq::JobLogger
    def call(item, queue)
      start = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC)
      @logger.info("start")
      @job_log = JobsDashboard::JobLog.create!(
        sidekiq_jid: item['jid'],
        status: 'queued',
        item_type: item['class'],
        args: item['args'],
        retry: item['retry'],
        queue: item['queue']
      )

      yield

      with_elapsed_time_context(start) do
        @logger.info("done")
        @job_log = @job_log || JobsDashboard::JobLog.find_by(sidekiq_jid: item['jid'])
        @job_log.update(status: 'complete', finished_at: Time.now) if @job_log
      end
    rescue Exception => e
      with_elapsed_time_context(start) do
        @logger.info("fail")
        @job_log = @job_log || JobsDashboard::JobLog.find_by(sidekiq_jid: item['jid'])
        @job_log.update(status: 'failed', finished_at: Time.now, backtrace: ([e.message] + e.backtrace)) if @job_log
      end

      raise
    end
  end
end