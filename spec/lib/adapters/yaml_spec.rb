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
      expect(FlipFlop.feature_enabled? :on).to be_truthy
      expect(FlipFlop.feature_enabled? :off).to be_falsey
    end

    it 'should still work for group gate' do
      user1 = { group: "a" }
      user2 = { group: "b" }

      FlipFlop::Group.register(:group_name) do |actor|
        actor[:group] == 'a'
      end

      expect(FlipFlop.feature_enabled? :group_example, user1).to be_truthy
      expect(FlipFlop.feature_enabled? :group_example, user2).to be_falsey
    end

    it 'on gate should work' do
      expect(FlipFlop.feature_enabled? :simple_on).to be_truthy
    end

    it 'off gate should work' do
      expect(FlipFlop.feature_enabled? :simple_off).to be_falsey
    end

  end
end