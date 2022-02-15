module JobsDashboard
  class DashboardController < ApplicationController

    def index
      @stats = JobLog.all.select("COUNT(id) as count, status").group(:status)
      @awaiting_jobs = JobLog.queued
      @ongoing_jobs = JobLog.working
    end

  end

end
