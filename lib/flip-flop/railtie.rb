require 'flip-flop/view_helpers'

module FlipFlop
  class Railtie < Rails::Railtie
    initializer "flip-flop.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end