# -*- encoding: utf-8 -*-
require File.expand_path('../lib/flip-flop/version', __FILE__)

plugin_files = []
plugin_test_files = []

ignored_files = plugin_files
ignored_files << ".gitignore"
ignored_files.uniq!

Gem::Specification.new do |gem|
  gem.authors       = ["Brian Kulyk"]
  gem.email         = ["brian@kulyk.ca"]
  gem.summary       = %q{Feature flipper}
  gem.description   = %q{Enable or disable features easily}
  gem.homepage      = "https://github.com/bkulyk/flip-flop"
  gem.license       = "MIT"
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n") - ignored_files + ["lib/flip-flop/version.rb"]
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "flip-flop"
  gem.require_paths = ["lib"]
  gem.version       = FlipFlop::VERSION
end