# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'numverify/version'

Gem::Specification.new do |spec|
  spec.name          = 'numverify'
  spec.version       = NumverifyClient::VERSION
  spec.authors       = ['Olivier Buffon']
  spec.email         = ['olivier@chronogolf.ca']

  spec.summary       = 'API Client for Numverify services'
  spec.description   = 'Numverify: Global Phone Number Validation & Lookup JSON API'
  spec.homepage      = 'https://github.com/chronogolf/numverify'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('excon', '~> 0.71.0')
  spec.add_dependency('json', '>= 2.3.0')

  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('webmock')
  spec.add_development_dependency('vcr')
end
