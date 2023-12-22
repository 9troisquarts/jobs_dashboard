module JobLogs
  class SearchJobLogs
    include Interactor

    def mongo_search(records)
      records = records.where(sidekiq_jid:  /.*#{params[:sidekiq_jid]}.*/i) if params[:sidekiq_jid].present?
      if params[:created_at_dategteq].present? && params[:created_at_datelteq].present?
        records = records.gte(created_at: params[:created_at_dategteq]).lte(created_at: params[:created_at_datelteq])
      end

      if params[:finished_at_dategteq].present? && params[:finished_at_datelteq].present?
        records = records.gte(finished_at: params[:finished_at_dategteq]).lte(finished_at: params[:finished_at_datelteq])
      end
      records
    end

    def active_record_search(records)
      records
    end

    def call
      params = context.params
      
      records = JobsDashboard::JobLog.all
      if params.present?
        records = records.where(item_type: params[:item_type]) if params[:item_type].present?
        records = records.where(status: params[:status]) if params[:status].present?
        records = records.where(queue: params[:queue]) if params[:queue].present?

        if defined? Mongoid
          records = mongo_search(records)
        else
          records = active_record_search(records)
        end
      end

      context.records = records
    end
  end
end