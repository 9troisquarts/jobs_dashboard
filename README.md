# JobsDashboard

JobsDashboard allows you to log all of your sidekiq jobs and provides an interface to visualize them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jobs_dashboard', git: 'https://github.com/9troisquarts/jobs_dashboard'
```

And then execute:

    $ bundle install

Run the migration generator:

```ruby
rails generate active_record:job_log_migration
```

Run the migration:

```ruby
rails db:migrate
```
## Usage

Set JobsDashboard::JobLogger as sidekiq default logger

```ruby
# initializers/sidekiq.rb
require 'jobs_dashboard'

Sidekiq.configure_client do |config|
  # accepts :expiration (optional)
  JobsDashboard.configure_client_middleware config
end

Sidekiq.configure_server do |config|
  # accepts :expiration (optional)
  JobsDashboard.configure_server_middleware config

  # accepts :expiration (optional)
  JobsDashboard.configure_client_middleware config
end
```

Mount Engine to access web component:

```ruby
# routes.rb
require 'jobs_dashboard/engine'

Rails.application.routes.draw do
  mount JobsDashboard::Engine, at: '/jobs_dashboard'
end
```

## Basic authentication

Set environment variable JOBS_DASHBOARD_AUTH_PASSWORD and JOBS_DASHBOARD_AUTH_USERNAME to activate the basic authentication

## Job Options

Options can be specified in worker's sidekiq_options with the key jobs_dashboard

```ruby
  sidekiq_options jobs_dashboard: { skip: true }
```

## Add a custom attribute

Custom attribute can be added on the jobs_dashboard_job_logs table

```ruby
bundle exec rails g migration add_***_to_jobs_dashboard_job_logs
```

In an initializer

```ruby
JobsDashboard.setup do |config|
  config.additional_params = [
    {
      attribute_name: 'attribute_name',
      title: 'Title displayed on column header and more'
    }
  ]
end
```

In the job
```ruby
include JobsDashboard::Worker
set_job_parameter(attribute_name, value)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jobs_dashboard.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
