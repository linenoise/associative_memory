begin
  require 'espec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'rspec'
end

require 'simplecov'
SimpleCov.start

desc "Run the specs under spec/"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--options', "spec/rspec.opts"]
  t.pattern = FileList['spec/**/*_spec.rb']
end
