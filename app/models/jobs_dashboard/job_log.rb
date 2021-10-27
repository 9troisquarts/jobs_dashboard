module JobsDashboard
  DEFAULT_LOCAL_TIME_ZONE = 'Europe/Paris'

  class JobLog < ApplicationRecord
    enum status: {
      queued: 'queued',
      working: 'working',
      retrying: 'retrying',
      complete: 'complete',
      failed: 'failed',
      interrupted: 'interrupted'
    }

    serialize :args, Array
    serialize :backtrace, Array

    validates :sidekiq_jid, presence: true, uniqueness: true

    def display_created_at
      created_at.in_time_zone(DEFAULT_LOCAL_TIME_ZONE).strftime('%Y-%m-%d %H:%M:%S')
    end

    def display_finished_at
      finished_at.in_time_zone(DEFAULT_LOCAL_TIME_ZONE).strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end