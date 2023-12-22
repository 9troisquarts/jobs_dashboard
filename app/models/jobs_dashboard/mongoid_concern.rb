module JobsDashboard::MongoidConcern
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic
    include Mongoid::Timestamps
    
    field :sidekiq_jid, type: String
    field :queue, type: String
    field :item_type, type: String
    field :status, type: String
    field :args, type: Array
    field :metadata, type: Hash
    field :logs, type: Array
    field :backtrace, type: Array
    field :finished_at, type: Date


    def self.created_before(date = Time.now - 15.days)
      self.lt(created_at: Time.now - date)
    end

    def self.stats
      stats = []
      statuses.each do |k, v|
        stats.push({ status: v, count: JobsDashboard::JobLog.send(k).count })
      end
      stats
    end
  end

end