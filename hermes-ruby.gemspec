# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hermes-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'hermes-ruby'
  spec.version       = HermesRuby::VERSION
  spec.authors       = ['Boris Drazhzhov']
  spec.email         = ['bdrazhzhov@gmail.com']

  spec.summary       = 'Allows to translate text from/to different languages using open API.'
  spec.description   = 'It uses translation API of Google, Microsoft, Yandex and other ones for translation. '\
                       'You can chose one of them and use. Unfortunately Yandex API is supported only.'
  spec.homepage      = 'https://github.com/bdrazhzhov/hermes-ruby'
  spec.license       = 'MIT'
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.58.0'
  spec.add_dependency 'querystring', '~> 0.1.0'
  spec.add_dependency 'rest-client', '~> 2.0'
end
