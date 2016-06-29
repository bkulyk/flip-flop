module FlipFlop
  module ViewHelpers

    # Check the if a feature should be enabled or not from a view
    #
    # Example:
    #   >> FlipFlop::get_instance.feature_enabled? :some_feature
    #
    # Arguments:
    #   feature_name (String/Symbol)
    #
    # Returns:
    #   boolean
    def feature_enabled?(feature_name, actor=nil)
      ::FlipFlop::feature_enabled? feature_name, actor
    end
  end
end