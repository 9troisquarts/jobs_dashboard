# frozen_string_literal: true
module JobsDashboard
  module ApplicationHelper
    def display_time time
      time.in_time_zone(DEFAULT_LOCAL_TIME_ZONE).strftime("%Y-%m-%d %I:%M:%S")
    end

    def status_label status
      case status
      when 'complete'
        return 'success'
      when 'failed', 'interrupted'
        return 'error'
      end
    end

    def item_types_collection
      JobLog.pluck(:item_type).uniq.sort
    end

    def statuses_collection
      JobLog.statuses.keys.map do |key|
        [I18n.t("jobs_dashboard.statuses.#{key}"), key]
      end
    end

    def queues_collection
      JobLog.pluck(:queue).uniq.sort
    end
  end
end