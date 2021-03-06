FlipFlop
========

[![Build Status](https://travis-ci.org/bkulyk/flip-flop.svg?branch=master)](https://travis-ci.org/bkulyk/flip-flop)
[![Code Climate](https://codeclimate.com/github/bkulyk/flip-flop/badges/gpa.svg)](https://codeclimate.com/github/bkulyk/flip-flop)

Provide an easy mechanism for turning features on or off, either with dates or just
a boolean value.

Install
-------

Add the following to your Gemfile

    gem 'flip-flop'

and run bundler to install

    $ bundle

or

    $ gem install flip-flop


Configure
---------

in `config/initializers/flip-flop.rb`

```ruby
require 'flip-flop/adapters/yaml'
FlipFlop.configure do |config|
  config[:adapter] = FlipFlop::Adapters::YAML
  config[:yaml_path] = 'config/flip_flop.yml'
end
```

and add a YAML file: `config/flip_flop.yml`

for example:

```yaml
---
:after_date_example:
  :type: :after_date
  :value: 2016-01-01
:until_date_example:
  :type: :until_date
  :value: 2020-01-01
:percentage_of_time_example:
  :type: :percentage_of_time
  :value: 50
:date_range_example:
  :type: :date_range
  :value: !ruby/range
    begin: 2016-01-01
    end: 2016-02-01
    excl: false
:time_range_example:
  :type: :time_range
  :value: !ruby/range
    begin: 2016-01-01 01:21:15 UTC
    end: 2016-01-02 01:24:15 UTC
    excl: true # include last second in this case (false is .. notation while true is ... when exec by ruby)
:rails_env_example:
  :type: :rails_env
  :value: :production
:another_rails_env_example:
  :type: :rails_env
  :value:
    - :production
    - :test
:group_example:
  :type: :group
  :value: :group_name
```

Example Usage
-------------

Once FlipFlop has been configured, (see above section) you can start checking if features
are enabled or not.

### In a Rails View:

```ruby
if feature_enabled? :my_cool_feature
  puts 'Cool'
else
  puts ''
end

```

### In a Rails Controller:

```ruby
class SomeController < ApplicationController
  include FlipFlop::ViewHelpers

  def my_action
    load_cool_stuff if feature_enabled? :cool_stuff
  end
end
```

### Without Rails:

```ruby
if FlipFlop.feature_enabled? :some_feature
  puts 'something'
else
  puts 'something else'
end
```

Gates
-----

* `boolean` &mdash; enable or disable a feature
* `after_date` &mdash; enable a feature after the date has passed
* `until_date` &mdash; enable a feature until the date has passed
* `date_range` &mdash; enable a feature for the duration of the date range
* `after_time` &mdash; enable a feature after a time has passed
* `until_time` &mdash; enable a feature until a time has passed
* `time_range` &mdash; enable a feature for the duration of a time range
* `percentage_of_time` &mdash; enable a feature for a given percentage of checks
* `rails_env` &mdash; enable a feature for a specified Rails environment
* `group` &mdash; enable a feature for a specified group of users (needs additional configuration)

Groups
------

To use the group adapter you need to register a group. For Ruby on Rails this can be done in an initializer.
Groups are reusable, many features can be tied to a single group.

```ruby
FlipFlop::Group.register(:administrators) do |user|
  user.is_admin?
end
```

Setup your feature definition. Here is an example using the YAML adapter:

```yaml
---
:awesome_admin_only_feature
  :type: :group
  :value: :administrators
```

When checking if the feature is enabled for that group you can provide the actor (user).

```ruby
FlipFlop.feature_enabled? :awesome_admin_only_feature, user
```

Adapters
--------

### Memory

This adapter is primarily used for testing, all configuration is stored in a
hash in memory.

### YAML

The `FlipFlop::Adapters::YAML` adapter is uses a YAML config file, to store info
about enabled and disabled features. The YAML file is parsed once when the application is
loaded. It's quick and easy to use, but it requres a deployment if a feature needs
to be quickly flipped.

### ActiveRecord

Allows feature settings to be stored in a database table. Because of typecasting and 
additional garbage collection this will not be as fast as the YAML adapter. Futher 
efforts will be made to makeing The ActiveRecord adapter more performant.

Extending FlipFlop
------------------

### Adding Custom Gates

You can easily add custom gates by adding methods to the `FlipFlop::Gates` module,
see the below example.

```ruby
module FlipFlop::Gates
  def always_on(value)
    true
  end
end
```

### Adding Custom Adapters

Custom adapters can be added by creating a new adapter class, and then setting the
adapter when configuring the FlipFlop. See the "Configure" for an example.

Contributing to FlipFlop
------------------------

* fork
* branch
* commit
* push
* pull request
