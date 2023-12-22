module JobLogs
  class SearchJobLogs
    include Interactor

    def call
      params = context.params
      
      records = JobsDashboard::JobLog.all
      if params.present?
        records = records.where("sidekiq_jid LIKE :sidekiq_jid", sidekiq_jid: "%#{params[:sidekiq_jid]}%") if params[:sidekiq_jid].present?
        records = records.where(item_type: params[:item_type]) if params[:item_type].present?
        records = records.where(status: params[:status]) if params[:status].present?
        records = records.where(queue: params[:queue]) if params[:queue].present?
        if params[:created_at_dategteq].present? && params[:created_at_datelteq].present?
          records = records.where("created_at >= :created_at_gt and created_at <= :created_at_lt", created_at_gt: params[:created_at_dategteq], created_at_lt: params[:created_at_datelteq]) 
        end

        if params[:finished_at_dategteq].present? && params[:finished_at_datelteq].present?
          records = records.where("finished_at >= :finished_at_gt and finished_at <= :finished_at_lt", finished_at_gt: params[:finished_at_dategteq], finished_at_lt: params[:finished_at_datelteq]) 
        end
      end

      context.records = records
    end
  end
end