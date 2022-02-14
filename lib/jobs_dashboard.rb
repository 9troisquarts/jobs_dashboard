# frozen_string_literal: true

require_relative "jobs_dashboard/version"
require_relative "jobs_dashboard/engine"
require_relative "jobs_dashboard/worker"
require 'jobs_dashboard/server_middleware'
require 'jobs_dashboard/client_middleware'
require 'jobs_dashboard/storage'

module JobsDashboard
  extend Storage
end
