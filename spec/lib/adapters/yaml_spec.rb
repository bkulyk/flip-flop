require 'spec_helper'
require 'flip-flop/adapters/yaml'

describe FlipFlop do
  context 'yaml' do

    before :each do
      FlipFlop::configure do |config|
        config[:adapter] = FlipFlop::Adapters::YAML
        config[:yaml_path] = 'spec/test-config.yml'
      end
    end

    it 'should load from yaml file' do
      expect(FlipFlop.get_instance.feature_enabled? :on).to be_truthy
      expect(FlipFlop.get_instance.feature_enabled? :off).to be_falsey
    end

  end
end