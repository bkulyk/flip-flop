require 'yaml'

module FlipFlop
  module Adapters
    module YAML
      include Memory

      DEFAULT_YAML_PATH = 'config/flip_flip.yml'

      def after_initialize
        @features = load_yaml
      end

      def yaml_path
        @config[:yaml_path] || DEFAULT_YAML_PATH
      end

      def load_yaml
        ::YAML.load_file(yaml_path) || {}
      end

      def write_yaml
        File.open(yaml_path, 'w') { |f| f.write @features.to_yaml }
      end
    end
  end
end