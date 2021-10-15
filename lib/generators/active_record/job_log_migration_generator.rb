require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class JobLogMigrationGenerator < Base
      source_root File.expand_path("../templates", __FILE__)
      argument :name, :type => :string, :default => "add_job_logs_table"

      def create_migration_file
        migration_template "migration.rb", "db/migrate/#{file_name}.rb"
      end

      protected

        def job_log_table_name
          'jobs_dashboard_job_logs'
        end

        def migration_version
          "[#{ActiveRecord::Migration.current_version}]"
        end
    end
  end
end
