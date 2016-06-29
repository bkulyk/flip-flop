require 'date'

module FlipFlop
  module Gates
    def boolean(value, actor)
      value
    end

    def date_range(value, actor)
      value.begin < Date.today && value.end > Date.today
    end

    def until_date(value, actor)
      Date.today < value
    end

    def after_date(value, actor)
      Date.today > value
    end

    def time_range(value, actor)
      value.begin < Time.now.utc && value.end > Time.now.utc
    end

    def until_time(value, actor)
      Time.now.utc < value
    end

    def after_time(value, actor)
      Time.now.utc > value
    end

    def percentage_of_time(value, actor)
      rand < (value / 100.0)
    end

    def rails_env(value, actor)
      value == Rails.env.to_sym || value.include?(Rails.env.to_sym)
    end

    def group(group_name, actor)
      Group.evaluate_group(group_name, actor)
    end
  end
end