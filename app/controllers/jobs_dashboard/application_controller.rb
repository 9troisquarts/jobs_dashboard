require 'kaminari'
module JobsDashboard
  class ApplicationController < ActionController::Base
    before_action :basic_auth
    before_action :set_locale
    before_action :clean_old_jobs

    private

    def basic_auth
      if ENV["JOBS_DASHBOARD_AUTH_USERNAME"].blank? || ENV["JOBS_DASHBOARD_AUTH_PASSWORD"].blank?
        raise 'Define a JOBS_DASHBOARD_AUTH_USERNAME and JOBS_DASHBOARD_AUTH_PASSWORD to access jobs dashboard' 
      end
      self.class.http_basic_authenticate_with name: ENV["JOBS_DASHBOARD_AUTH_USERNAME"], password: ENV["JOBS_DASHBOARD_AUTH_PASSWORD"]
    end
    
    def set_locale
      I18n.locale = :fr
    end

    def clean_old_jobs
      JobsDashboard::JobLog.queued.created_before(Time.now - 15.days).update_all(status: "dead")
      JobsDashboard::JobLog.working.created_before(Time.now - 15.days).update_all(status: "dead")
    end
  end
end
