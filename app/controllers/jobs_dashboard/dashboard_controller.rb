module JobsDashboard
  class DashboardController < ApplicationController

    def index
      @stats = JobLog.stats
      @awaiting_jobs = JobLog.queued
      @ongoing_jobs = JobLog.working
    end

  end

end
