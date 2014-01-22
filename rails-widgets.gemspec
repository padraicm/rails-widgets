# vim:fileencoding=utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'widgets/version'
require 'English'

Gem::Specification.new do |spec|
  spec.name          = 'rails-widgets'
  spec.version       = Widgets::VERSION
  spec.authors       = ['Paolo Dona']
  spec.email         = ['paolo.dona@gmail.com']
  spec.description   = %q{A collection of UI widgets for RubyOnRails}
  spec.summary       = %q{A collection of UI widgets for RubyOnRails}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rails', '>= 3.2'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'railties', '>= 3.2'
end
