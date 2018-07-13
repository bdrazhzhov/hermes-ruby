# HermesRuby

Allows to translate text from/to different languages using open API.

Yandex Translate API is supported only.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hermes-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hermes-ruby

## Usage

```ruby
require 'hermes-ruby'

# Create Yandex Translate client
# API Key can be obtained here https://translate.yandex.com/developers/keys
client = HermesRuby::Yandex.new('you_api_key')

# List of supported languages
client.get_langs

# Attempt to detect text language
client.detect('Hello!', [:en, :de])

# Text translation
client.translate('Hello!', 'en-ru') 
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
