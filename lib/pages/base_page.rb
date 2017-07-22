require 'capybara/dsl'

class BasePage
  include Capybara::DSL

  attr_reader :base_url

  @base_url = 'https://www.facebook.com/'

  def homepage
    visit(base_url)
  end

  def reload
    driver.browser.navigate.refresh
  end

  def logged_out?

  end

  def logged_in?

  end
end
