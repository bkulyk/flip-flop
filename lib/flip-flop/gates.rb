require 'date'

module FlipFlop
  module Gates
    def boolean(value)
      value
    end

    def date_range(value)
      value.begin < Date.today && value.end > Date.today
    end

    def until_date(value)
      Date.today < value
    end

    def after_date(value)
      Date.today > value
    end

    def time_range(value)
      value.begin < Time.now.utc && value.end > Time.now.utc
    end

    def until_time(value)
      Time.now.utc < value
    end

    def after_time(value)
      Time.now.utc > value
    end

    def percentage_of_time(value)
      rand < (value / 100.0)
    end

    def rails_env(value)
      value == Rails.env.to_sym || value.include?(Rails.env.to_sym)
    end
  end
end