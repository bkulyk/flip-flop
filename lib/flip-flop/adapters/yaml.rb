require 'date'

module FlipFlop
  module Adapters
    module YAML
      include Memory

      def after_initialize
        @features = load_yaml
      end

      def load_yaml
        ::YAML.load_file(@config[:yaml_path]) || {}
      end

      def write_yaml
        File.open(@config[:yaml_path], 'w') { |f| f.write @features.to_yaml }
      end
    end
  end
end