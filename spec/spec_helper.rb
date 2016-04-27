$:.unshift(File.expand_path('../lib', __FILE__))

require 'pathname'
FlopFlopRoot = Pathname(__FILE__).dirname.join('..').expand_path

require 'rubygems'
require 'bundler'

Bundler.setup(:default, :test)

require 'flip-flop'

RSpec.configure {}