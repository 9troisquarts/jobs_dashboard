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

    if ActiveRecord.version >= Gem::Version.new('7.1')
      serialize :args, coder: Array
      serialize :metadata, coder: Hash
      serialize :logs, coder: Array
      serialize :backtrace, coder: Array
    else
      serialize :args, Array
      serialize :metadata, Hash
      serialize :logs, Array
      serialize :backtrace, Array
    end
    
    validates :sidekiq_jid, presence: true, uniqueness: true

    def self.ransackable_attributes(auth_object = nil)
      [
        "sidekiq_jid",
        "item_type",
        "queue",
        "status",
        "created_at", 
        "finished_at", 
      ]
    end
  end
end