require 'flip-flop/gates'
require 'flip-flop/adapters/memory'
require 'flip-flop/railtie' if defined? Rails
require 'flip-flop/group'

module FlipFlop

  # Get the instnace of FlipFlop or initialize a new one.
  #
  # Example:
  #   >> FlipFlop::get_intance
  #   => <FlipFlop::FlipFlop>
  def self.get_instance
    @flip_flop ||= FlipFlop.new
  end

  # Initialize and configure FlipFlop for use
  #
  # Example:
  #   >> FlipFlop::configure { |config| config[:adapter] = FlipFlop::Adapters::Memory }
  #
  # Arguments:
  #   configuration block: (block)
  def self.configure(&block)
    @flip_flop = FlipFlop.new
    @flip_flop.configure(&block)
  end

  # Check if a feature is enabled or not
  #
  # Example:
  #   >> puts "hello" if FlipFlop::feature_enabled? :say_hello
  #
  # Arguments:
  #   feature_name (String/Symbol)
  def self.feature_enabled?(feature_name, actor=nil)
    get_instance.feature_enabled? feature_name.to_sym, actor
  end
  
  class FlipFlop
    attr_reader :config

    # Initialize and configure FlipFlop for use
    #
    # Example:
    #   >> FlipFlop::get_instance.configure { |config| config[:adapter] = FlipFlop::Adapters::Memory }
    #
    # Arguments:
    #   configuration block: (block)
    def configure
      @config ||= {}
      yield @config

      initialize_adapter
    end

    # Check the if a feature should be enabled or not
    #
    # Example:
    #   >> FlipFlop::get_instance.feature_enabled? :some_feature
    #
    # Arguments:
    #    feature_name (Symbol)
    #
    # Returns:
    #   boolean
    def feature_enabled?(feature_name, actor=nil)
      public_send feature_type(feature_name), feature_value(feature_name), actor
    rescue
      false
    end

    private

    # If no adapter has been configured, use memory, then run the `after_initialize`
    # method defined in the adapter if it's there
    def initialize_adapter
      # if no adapter has been initialized, use memory adapter
      config[:adapter] ||= Adapters::Memory

      extend config[:adapter]
      after_initialize if respond_to? :after_initialize
    end

    include Gates
  end
end