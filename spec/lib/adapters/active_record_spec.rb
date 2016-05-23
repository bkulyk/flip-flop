require 'spec_helper'
require 'flip-flop/adapters/active_record'
require 'generators/templates/migration'

ActiveRecord::Migration.verbose = false

describe FlipFlop::Adapters::ActiveRecord do
  context 'ActiveRecord' do

    before :all do
      ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
      FlipFlop.configure { |config| config[:adapter] = FlipFlop::Adapters::ActiveRecord }
    end

    before :each do
      CreateFlipFlopFeatureTable.up
      FlipFlop.get_instance.set_feature :db, :boolean, true
    end

    after :each do
      CreateFlipFlopFeatureTable.down
    end

    it 'should save a feature to the database' do
      r = FlipFlop::Adapters::ActiveRecord::Feature.all
      expect(r.size).to eql 1
      expect(r.first.name).to eql :db
      expect(r.first.value).to be_truthy
      expect(r.first.gate_type).to eql :boolean
    end

    it 'should return true for a bool' do
      expect(FlipFlop.feature_enabled?(:db)).to be_truthy
    end

    it 'should be changeable' do
      FlipFlop.get_instance.set_feature :db, :boolean, false
      r = FlipFlop::Adapters::ActiveRecord::Feature.all
      expect(r.size).to eql 1
      expect(r.first.name).to eql :db
      expect(r.first.value).to be_falsey
      expect(r.first.gate_type).to eql :boolean
    end

    it 'should still work with other datatypes' do
      FlipFlop.get_instance.set_feature :dates, :date_range, (Date.today - 2)..(Date.today + 2)
      expect(FlipFlop.feature_enabled?(:dates)).to be_truthy
    end

  end
end
