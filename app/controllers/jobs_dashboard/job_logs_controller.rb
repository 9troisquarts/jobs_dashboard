module JobsDashboard
  class JobLogsController < ApplicationController
    def index
      context = JobLogs::GetJobLogs.call(params: authorized_params, pagination_params: { page: authorized_params[:page], per_page: 100 })
      
      @search = authorized_params || {}
      @job_logs = context.records
    end

    def show
      @job_log = JobLog.find_by(sidekiq_jid: params[:id])
      @title = "#{@job_log.item_type}"
    end

    private

    def authorized_params
      params.permit(:item_type, :status, :queue, :sidekiq_jid, :page, :created_at_dategteq, :created_at_datelteq, :finished_at_dategteq, :finished_at_datelteq)
    end
  end
end
