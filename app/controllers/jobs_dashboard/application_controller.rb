require 'kaminari'
module JobsDashboard
  class ApplicationController < ActionController::Base
    before_action :basic_auth
    before_action :set_locale

    private

      def basic_auth
        return unless ENV["JOBS_DASHBOARD_AUTH_USERNAME"].present? && ENV["JOBS_DASHBOARD_AUTH_PASSWORD"].present?
        self.class.http_basic_authenticate_with name: ENV["JOBS_DASHBOARD_AUTH_USERNAME"], password: ENV["JOBS_DASHBOARD_AUTH_PASSWORD"]
      end
      
      def set_locale
        I18n.locale = :fr
      end
  end
end
