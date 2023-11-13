module JobsDashboard
  class JobLogsController < ApplicationController
    def index
      @q = JobLog.ransack(params[:q])

      @job_logs = @q.result(distinct: true).order(created_at: :desc)
      if @job_logs.respond_to?(:page)
        @job_logs = @job_logs.page(params[:page]).per(100)
      end
    end

    def show
      @job_log = JobLog.find_by(sidekiq_jid: params[:id])
      @title = "#{@job_log.item_type}"
    end
  end
end
