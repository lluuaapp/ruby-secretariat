require_relative "lib/secretariat/version"

Gem::Specification.new do |s|
  s.name = "secretariat"
  s.version = Secretariat::VERSION
  s.summary = "A ZUGFeRD xml generator"
  s.description = "a tool to help generate and validate ZUGFeRD invoice xml files"
  s.authors = ["Jan Krutisch"]
  s.email = "jan@krutisch.de"
  s.homepage = "https://github.com/halfbyte/ruby-secretariat"
  s.license = "Apache-2.0"

  s.extra_rdoc_files = ["README.md"]

  # Specify which files should be added to the gem when it is released.
  s.files = Dir["lib/**/*.rb"]

  s.files += [
    "secretariat.gemspec"
  ]

  s.require_paths -= ["lib/secretariat/validator.rb"]

  # enable these if you need verification
  # s.files += Dir["schemas/**/*"]
  # s.add_dependency "nokogiri", "~> 1.10"
  # s.add_dependency "schematron-nokogiri", "~> 0.0", ">= 0.0.3"

  s.required_ruby_version = ">= 3.1.0"

  s.metadata['rubygems_mfa_required'] = 'true'
end
