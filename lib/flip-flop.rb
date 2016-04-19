require 'flip-flop/gates'
require 'flip-flop/adapters/memory'

module FlipFlop
  def self.get_instance
    @flip_flop ||= FlipFlop.new
  end

  def self.configure(&block)
    get_instance.configure(&block)
  end
  
  class FlipFlop
    include Gates

    attr_accessor :config, :path

    def configure
      @config ||= {}
      yield @config

      initialize_adapter
    end

    def initialize_adapter
      # if no adapter has been initialized, use memory adapter
      config[:adapter] ||= Adapters::Memory

      extend config[:adapter]
      after_initialize if respond_to? :after_initialize
    end

    def feature_enabled?(name)
      public_send feature_type(name), feature_value(name)
    rescue
      false
    end

  end
end

require 'flip-flop/railtie' if defined? Rails