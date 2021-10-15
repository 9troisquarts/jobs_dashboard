module JobsDashboard
  class JobLogsController < ApplicationController
    def index
      @job_logs = JobLog.all.order(created_at: :desc)
      @job_logs = @job_logs.page(params[:page]).per(100)
    end

    def show
      @job_log = JobLog.find_by(sidekiq_jid: params[:id])
    end
  end
end