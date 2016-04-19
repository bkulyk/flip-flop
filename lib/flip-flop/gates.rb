require 'date'

module FlipFlop
  module Gates
    def boolean(value)
      value
    end

    def date_range(value)
      value.include? Date.today
    end

    def until_date(value)
      Date.today < value
    end

    def after_date(value)
      Date.today > value
    end

    def percentage_of_time(value)
      rand < (value / 100.0)
    end
  end
end