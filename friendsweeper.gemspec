# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "friendsweeper/version"

Gem::Specification.new do |spec|
  spec.name          = "friendsweeper"
  spec.version       = Friendsweeper::VERSION
  spec.authors       = ["Omar Kassouar"]
  spec.email         = ["spam@kassouar.com"]

  spec.summary       = %q{Quick tool to erase all evidence of a (former?) Facebook friendship. Burn those bridges!}
  spec.homepage      = "https://github.com/O-kasso/friendsweeper"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_runtime_dependency 'capybara', '~> 2.14'
  spec.add_runtime_dependency 'selenium-webdriver', '~> 3.4'
  spec.add_runtime_dependency 'chromedriver-helper', '~> 1.1'
  spec.add_runtime_dependency 'site_prism', '~> 2.9'
  spec.add_runtime_dependency 'commander', '~> 4.4'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'


  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files        = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  spec.bindir        = 'bin'
  spec.executables   = `git ls-files -- bin/*`.split('\n').map { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
