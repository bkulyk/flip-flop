#!/usr/bin/env rake

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "flip-flop/version"

# gem install pkg/*.gem
# gem uninstall flip-flop
desc 'Build gem into the pkg directory'
task :build do
  FileUtils.rm_rf('pkg')
  Dir['*.gemspec'].each do |gemspec|
    system "gem build #{gemspec}"
  end
  FileUtils.mkdir_p('pkg')
  FileUtils.mv(Dir['*.gem'], 'pkg')
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color)
end

task :default => :spec