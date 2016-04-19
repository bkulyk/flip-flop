module FlipFlop
  module ViewHelpers
    def feature_enabled?(feature_name)
      FlipFlop::get_instance.feature_enabled? feature_name.to_sym
    end
  end
end