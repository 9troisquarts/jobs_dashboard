# frozen_string_literal: true

require_relative "lib/jobs_dashboard/version"

Gem::Specification.new do |spec|
  spec.name          = "jobs_dashboard"
  spec.version       = JobsDashboard::VERSION
  spec.authors       = ["Patryk"]
  spec.email         = ["patryk@9troisquarts.com"]

  spec.summary       = "Sidekiq jobs dashboard"
  spec.homepage      = "https://github.com/9troisquarts/jobs_dashboard"
  spec.license       = "MIT"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/9troisquarts/jobs_dashboard"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'sidekiq', '>= 6.0'
  spec.add_dependency 'kaminari'
  spec.add_dependency 'slim-rails'
  spec.add_dependency 'ransack'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
