module JobsDashboard::ActiveRecordConcern
  extend ActiveSupport::Concern

  included do
    def self.created_before(date = Time.now - 15.days)
      self.where("created_at <= :created_at", created_at: date)
    end

    def self.stats
      JobLog.all.select("COUNT(id) as count, status").group(:status)
    end
  end
end