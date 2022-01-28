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
