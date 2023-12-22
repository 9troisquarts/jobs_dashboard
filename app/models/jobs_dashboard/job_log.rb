module JobsDashboard
  DEFAULT_LOCAL_TIME_ZONE = 'Europe/Paris'

  class JobLog < ApplicationRecord
    if defined? Mongoid
      include JobsDashboard::MongoidConcern
    else
      include JobsDashboard::ActiveRecordConcern
    end  
    
    validates :sidekiq_jid, presence: true, uniqueness: true
    validates :status, inclusion: { in: %w[queued working retrying complete failed interrupted dead] }
    
    
    scope :queued, -> { where(status: 'queued' )}
    scope :working, -> { where(status: 'working' )}
    scope :retrying, -> { where(status: 'retrying' )}
    scope :complete, -> { where(status: 'complete' )}
    scope :failed, -> { where(status: 'failed' )}
    scope :dead, -> { where(status: 'dead' )}
    scope :interrupted, -> { where(status: 'interrupted' )}

    def self.statuses
      {
        queued: 'queued',
        working: 'working',
        retrying: 'retrying',
        complete: 'complete',
        failed: 'failed',
        interrupted: 'interrupted',
        dead: 'dead',
      }
    end
  end
end