# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-outreach/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-outreach"
  gem.version       = Omniauth::Outreach::VERSION
  gem.authors       = ["Anders Fredriksson", "Outreach Engineering"]
  gem.email         = ["platform@outreach.io"]

  gem.summary       = "An Outreach.io OAuth2 strategy for OmniAuth."
  gem.description   = "An Outreach.io OAuth2 strategy for OmniAuth."
  gem.homepage      = "https://github.com/proleadsio/omniauth-outreach"
  gem.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if gem.respond_to?(:metadata)
  #  gem.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|gem|features)/})
  end
  gem.bindir        = "exe"
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 2.1"
  gem.add_development_dependency "rake", "~> 10.0"
  #gem.add_development_dependency "rgem", "~> 3.0"

  gem.add_dependency "oauth2",     "~> 1.1"
  gem.add_dependency "omniauth",   "~> 1.2"

end
