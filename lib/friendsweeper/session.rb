require 'capybara'
require 'selenium-webdriver'
require 'site_prism'

module Session
  CHROME_SWITCHES = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: [
        '--disable-notifications',
        '--disable-save-password',
        '--disable-infobars',
        '--disable-extensions',
        '--start-maximized'
      ]
    }
  )

  # prevent browser quitting after execution completes
  Capybara::Selenium::Driver.class_eval { def quit; end }

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: CHROME_SWITCHES
    )
  end

  Capybara.configure do |c|
    c.default_driver = :selenium
    c.app_host = 'https://www.facebook.com'
    c.enable_aria_label = true
  end

  SitePrism.configure do |config|
    config.use_implicit_waits = true
  end
end
