class <%= migration_class_name %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= job_log_table_name %> do |t|
      t.string :sidekiq_jid, :null => false
      t.string :status
      t.string :item_type
      t.text :args
      t.boolean :retry, null: false, default: false
      t.string :queue
      t.text :backtrace
      t.datetime :finished_at
      t.timestamps
    end

    add_index :<%= job_log_table_name %>, :sidekiq_jid, :unique => true
    add_index :<%= job_log_table_name %>, :updated_at
  end
end
