# Json::Schema::Generator::Rough

Rough JSON schema generator in ruby.

## Features

* Multiple JSONs into single JSON schema
* Extract the schema of object values by JSON Path for `patternProperties`
* Extract the enumerated values by JSON Path
* Detect required object keys

## Usage

With `json-schema-generator-rough` command:

```
$ json-schema-generator-rough \
  --pattern-properties \
    '$.operations.*' \
    '$.shapes.*' \
    '$.shapes.*.members' \
  /path/to/one.json \
  /path/to/another.json
```

Or in your ruby script:

```ruby
require 'json-schema-generator-rough'

generator = JSON::SchemaGenerator::Rough.new
schema = generator.generate(json_str)

puts JSON.pretty_generate JSON.parse(schema)
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json-schema-generator-rough'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json-schema-generator-rough


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json-schema-generator-rough.
