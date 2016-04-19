require 'date'

module FlipFlop
  module Adapters
    module Memory
      attr_accessor :features

      def after_initialize
        @features = {}
      end
      
      def get_feature(name)
        @features[name] || nil
      end

      def set_feature(name, type, value)
        @features[name] = {type: type, value: value}
      end

      def disable_feature(name)
        set_feature(name, :boolean, false)
      end

      def feature_type(name)
        @features[name][:type]
      end

      def feature_value(name)
        @features[name][:value]
      end
    end
  end
end