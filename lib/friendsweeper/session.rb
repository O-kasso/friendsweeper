require 'capybara'
require 'selenium-webdriver'

module Session
  chrome_switches = Selenium::WebDriver::Remote::Capabilities.chrome(
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

  Capybara::Selenium::Driver.class_eval { def quit; end } # prevent browser quitting after execution completes
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   browser: :chrome,
                                   desired_capabilities: chrome_switches)
  end

  Capybara.default_driver = :selenium
  Capybara.enable_aria_label = true
end
