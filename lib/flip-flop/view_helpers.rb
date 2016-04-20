module FlipFlop
  module ViewHelpers

    # Check the if a feature should be enabled or not from a view
    #
    # Example:
    #   >> FlipFlop::get_instance.feature_enabled? :some_feature
    #
    # Arguments:
    #   configuration block: (:symbol)
    #
    # Returns:
    #   boolean
    def feature_enabled?(feature_name)
      ::FlipFlop::get_instance.feature_enabled? feature_name.to_sym
    end
  end
end