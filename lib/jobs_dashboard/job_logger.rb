require 'sidekiq/job_logger'

module JobsDashboard
  class JobLogger < Sidekiq::JobLogger
    def call(item, queue)
      # Logs job parameters if they exist
      Sidekiq::Logging.with_context("") do
        begin
          start = ::Process.clock_gettime(::Process::CLOCK_MONOTONIC)
          logger.info("start")
          job_log = JobsDashboard::JobLog.create!(
            sidekiq_jid: item['jid'],
            status: 'queued',
            item_type: item['class'],
            args: item['args'],
            retry: item['retry'],
            queue: item['queue']
          )
          yield
          logger.info("done: #{elapsed(start)} sec")
          job_log.update(status: 'complete')
        rescue Exception => e
          logger.info("fail: #{elapsed(start)} sec")
          job_log.update(status: 'failed', backtrace: ([e.message] + e.backtrace))
          raise
        end
      end
    end
  end
end