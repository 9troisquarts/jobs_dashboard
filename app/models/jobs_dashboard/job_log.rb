module JobsDashboard
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
      created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end