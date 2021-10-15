# JobsDashboard

JobsDashboard allows you to log all of your sidekiq jobs and provides an interface to visualize them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jobs_dashboard'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jobs_dashboard

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
Sidekiq.configure_server do |config|
  require 'jobs_dashboard/job_logger'
  config.options[:job_logger] = JobsDashboard::JobLogger
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jobs_dashboard.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
