module JobsDashboard
  class Engine < ::Rails::Engine
    isolate_namespace JobsDashboard
    initializer "jobs_dashboard.assets.precompile" do |app|
      app.config.assets.precompile += %w( jobs_dashboard/application.css )
    end

    require 'slim-rails'
  end

  self.mattr_accessor :additional_params
  self.additional_params = []

  def self.setup(&block)
    yield self
  end
end

