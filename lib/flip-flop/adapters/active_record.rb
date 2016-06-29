require 'active_record'

module FlipFlop
  module Adapters
    module ActiveRecord

      # override this method to prevent the feature being loaded from the
      # database twice.
      def feature_enabled?(feature_name, actor=nil)
        f = get_feature(feature_name)
        public_send f.gate_type, f.value, actor
      rescue
        false
      end
      
      def get_feature(name)
        Feature::find_by_name(name)
      end

      # Load the record from the DB if it's already there, and store
      # the gate type and value
      def set_feature(name, gate_type, value)
        f = Feature::find_or_initialize_by(name: name)
        f.gate_type = gate_type
        f.value = value
        f.save
      end

      # Diable the feature by deleting the record from the DB
      def disable_feature(name)
        get_feature(name).delete
      end

      # here for compatability, should not really be used
      def feature_type(name)
        get_feature(name).gate_type.to_sym
      end

      # here for compatabilty, should not really be used
      def feature_value(name)
        get_feature(name).value
      end

      class Feature < ::ActiveRecord::Base
        self.table_name = 'flip_flop_features'.freeze
        serialize :value

        # getter to type case to symbol
        def name
          super.to_sym
        end

        # getter to type case to symbol
        def gate_type
          super.to_sym
        end

      end
    end
  end
end
