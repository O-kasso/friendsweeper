#require 'bundler/setup' ...do I need this?
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'site_prism'

require 'friendsweeper/pages'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app)
end

Capybara.configure do |c|
  c.javascript_driver = :poltergeist
  c.default_driver = :poltergeist
  c.enable_aria_label = true
end

Capybara.app = Rack::File.new File.dirname __FILE__

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

