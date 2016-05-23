require 'spec_helper'
require 'flip-flop/view_helpers'

ONE_DAY = 86400

class DummyController
  include FlipFlop::ViewHelpers
end

describe DummyController do
  before :each do
     FlipFlop.configure {}
  end

  describe '#feature_enabled?' do
    it 'should return false if nothing has been set' do
      expect(subject.feature_enabled? :asdf).to be_falsey
    end

    context 'boolean gate' do
      before :each do
        ::FlipFlop::get_instance.set_feature(:asdf, :boolean, :true)
      end

      it 'should return true if the feature has been enabled' do
        expect(subject.feature_enabled? :asdf).to be_truthy
      end

      it 'should return false if the feature has been disabled' do
        ::FlipFlop::get_instance.disable_feature(:asdf)
        expect(subject.feature_enabled? :asdf).to be_falsey
      end
    end

    context 'until_date gate' do
      it 'should return true if the feature has been set to expire in the future' do
        ::FlipFlop::get_instance.set_feature(:something, :until_date, Date.today + 3)
        expect(subject.feature_enabled? :something).to be_truthy
      end

      it 'should return false if the feature has been set to expire in the past' do
        FlipFlop::get_instance.set_feature(:something, :until_date, Date.today - 3)
        expect(subject.feature_enabled? :something).to be_falsey
      end
    end

    context 'after_date gate' do
      it 'should return true if the feature has been set to expire after a date in the past' do
        FlipFlop::get_instance.set_feature(:blah, :after_date, Date.today - 3)
        expect(subject.feature_enabled? :blah).to be_truthy
      end

      it 'should return false if the feature has been set to enable after a date in the future' do
        FlipFlop::get_instance.set_feature(:blah, :after_date, Date.today + 3)
        expect(subject.feature_enabled? :blah).to be_falsey
      end
    end

    context 'date range gate' do
      it 'feature should be enabled if current date is in the date range' do
        FlipFlop::get_instance.set_feature(:ranged, :date_range, (Date.today - 1)..(Date.today + 1))
        expect(subject.feature_enabled? :ranged).to be_truthy
      end

      it 'feature should be disabled if range not started yet' do
        ::FlipFlop::get_instance.set_feature(:ranged, :date_range, (Date.today + 1)..(Date.today + 2))
        expect(subject.feature_enabled? :ranged).to be_falsey
      end

      it 'feature should be disabled if range is past' do
        ::FlipFlop::get_instance.set_feature(:ranged, :date_range, (Date.today - 4)..(Date.today - 2))
        expect(subject.feature_enabled? :ranged).to be_falsey
      end
    end

    context 'until time gate' do
      it 'should return true if the feature has been set to expire in the future' do
        ::FlipFlop::get_instance.set_feature(:something, :until_time, Time.now.utc + 60)
        expect(subject.feature_enabled? :something).to be_truthy
      end

      it 'should return false if the feature has been set to expire in the past' do
        FlipFlop::get_instance.set_feature(:something, :until_time, Time.now.utc - 60)
        expect(subject.feature_enabled? :something).to be_falsey
      end
    end

    context 'after time gate' do
      it 'should return true if the feature has been set to expire after a time in the past' do
        FlipFlop::get_instance.set_feature(:blah, :after_time, Time.now.utc - 10)
        expect(subject.feature_enabled? :blah).to be_truthy
      end

      it 'should return false if the feature has been set to enable after a time in the future' do
        FlipFlop::get_instance.set_feature(:blah, :after_time, Time.now.utc + 10)
        expect(subject.feature_enabled? :blah).to be_falsey
      end
    end

    context 'time range gate' do
      it 'feature should be enabled if current date is in the time range' do
        FlipFlop::get_instance.set_feature(:ranged, :time_range, (Time.now.utc - ONE_DAY)..(Time.now.utc + ONE_DAY))
        expect(subject.feature_enabled? :ranged).to be_truthy
      end

      it 'feature should be disabled if range not started yet' do
        ::FlipFlop::get_instance.set_feature(:ranged, :time_range, (Time.now.utc + 60)..(Time.now.utc + ONE_DAY))
        expect(subject.feature_enabled? :ranged).to be_falsey
      end

      it 'feature should be disabled if range is past' do
        ::FlipFlop::get_instance.set_feature(:ranged, :time_range, (Time.now.utc - ONE_DAY)..(Time.now.utc - 60))
        expect(subject.feature_enabled? :ranged).to be_falsey
      end
    end
  end

end