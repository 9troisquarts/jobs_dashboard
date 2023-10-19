## [0.2.2] - 2023-10-19

- Added log of error message. Create a migration to add logging of error message:
```
class AddErrorMessageToJobsDashboardJobLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs_dashboard_job_logs, :error_message, :text, limit: 4294967295
  end
end
```
## [0.2.1] - 2023-10-19

- Raise if basic auth params are not defined

## [0.1.7] - 2022-01-28 
- Improve dashboard performances

## [0.1.5] - 2021-11-18

- Increase limit of args text field.

If you are migrating from < 0.1.5 to 0.1.5 you have to create a migration to update text fields:
```
  def change
    change_column :jobs_dashboard_job_logs, :args, :text, limit: 4294967295
    change_column :jobs_dashboard_job_logs, :backtrace, :text, limit: 4294967295
  end
```
## [0.1.2] - 2021-11-02

- Add queue information
- Improve job arguments display

## [0.1.1] - 2021-10-29

- Fix logging of backtrace

## [0.1.0] - 2021-10-07

- Initial release
