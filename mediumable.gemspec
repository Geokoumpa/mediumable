# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mediumable/version'

Gem::Specification.new do |gem|
  gem.name          = "mediumable"
  gem.version       = Mediumable::VERSION
  gem.authors       = ["John Tsiligkakis", "George Koumparoulis"]
  gem.email         = ["george.koumparoulis@gmail.com", 'gtsiligkakis@gmail.com']
  gem.description   = %q{Adds mediumable functionality to models through acts_as_mediumable}
  gem.summary       = %q{Mediumable functionality}
  gem.homepage      = "https://github.com/Geokoumpa/mediumable.git"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
