[![CircleCI](https://circleci.com/gh/chronogolf/numverify/tree/master.svg?style=shield&circle-token=a035ff061b42aa7812b0db6e744f2168a2f6eb13)](https://circleci.com/gh/chronogolf/numverify/tree/master) [![Code Climate](https://codeclimate.com/github/chronogolf/numverify/badges/gpa.svg)](https://codeclimate.com/github/chronogolf/numverify) [![Gem Version](https://badge.fury.io/rb/numverify.svg)](https://badge.fury.io/rb/numverify)

# Numverify API Client

This gem is a non-official Ruby Client for Numverify API service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'numverify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install numverify

## Usage

#### Requirements

In order to use the client with your Numverify account I'll need to specify you `ACCESS_KEY`
This can be done through an initializer like:
```ruby
NumverifyClient.configure do |config|
  config.access_key = NUMVERIFY_ACCESS_KEY
end
```
Or more permanently by using the environment variable
```ruby
ENV['NUMVERIFY_ACCESS_KEY']
```

_*Optional*_:  You can also choose to use the service through `https`:
```ruby
NumverifyClient.configure do |config|
  ...
  config.https = true
end
```


#### Number Validation:

To validate a phone number just use the `validate` method like:
```ruby
NumverifyClient.validate(number: '4158586273')
```
Optionally, you can also specify the country code:
```ruby
NumverifyClient.validate(number: '4158586273', country_code: 'US')
```
This will return the API response as a `NumverifyClient::Result` object.

## Error handling

Here is the list of every error managed by the gem:

|API error code|Error class name           |
|:-------------|---------------------------|
|404           |NotFoundError              |
|101           |InvalidAccessKeyError      |
|103           |InvalidApiFunctionError    |
|210           |NoPhoneNumberError         |
|211           |NonNumericPhoneNumberError |
|310           |InvalidCountryCodeError    |
|104           |UsageLimitError            |
|105           |HttpsAccessRestrictionError|
|102           |InactiveUserError          |
|Other         |APIError                   |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chronogolf/numverify.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

