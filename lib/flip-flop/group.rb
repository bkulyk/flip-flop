module FlipFlop

  class Group

    @@groups = {}

    def self.register group_name, &block
      @@groups[group_name] = block
    end

    def self.evaluate_group group_name, actor
      @@groups[group_name].call actor
    rescue
      false
    end

  end

end