# MethodArguments

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/method_arguments`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'method_arguments'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install method_arguments

## Usage

### Filter out unspecified keyword arguments

```ruby
class MyObject
  def example_method(first_name:)
    puts first_name
  end
end

MethodArguments.new(MyObject.new).example_method(first_name: "Sam", last_name: "Smith")
    #=> "Sam"
```

### Require keyword args not to be nil

```ruby
class MyObject
  def example_method(first_name:)
    puts first_name
  end
end

MethodArguments::NonNilForRequiredArgs.new(MyObject.new).example_method(first_name: nil)
    #=> TypeError, keyword first_name: cannot be nil!
```

## Limitation

Currently does not handle anything other than keywords.

Mocking an object with RSpec renders this tool ineffective 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/method_arguments.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

