#!/usr/bin/env ruby

require 'rubygems'
require 'commander'
require 'io/console'
require 'capybara'
require 'selenium-webdriver'
require_relative '../lib/pages/friendship'
require 'byebug'

class FriendSweeper
  include Commander::Methods
  # include whatever modules you need

  def run
    program :name, 'friendsweeper'
    program :version, '0.0.1'
    program :description, 'Quick tool to erase all evidence of a Facebook friendship'

    command :delete do |c|
      c.syntax = 'friendsweeper delete'
      c.description = 'Delete all public stories between you and a (former?) friend'
      c.action do |args, options|
        puts 'Make sure you know the Facebook usernames of both yourself and your friend. More info can be found at https://www.facebook.com/username'
        username = ask 'Your Facebook username: '
        friend_username = ask 'Username of friend you wish to erase: '

        puts 'Launching Facebook! You have 15 seconds to login so the script can continue!'

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

        friendship_page = FriendshipPage.new(username, friend_username)
        friendship_page.launch
        sleep 15
        begin
          friendship_page.delete_latest_story
        rescue Exception => e
          puts e
        end
      end
    end

    run!
  end
end

FriendSweeper.new.run if $0 == __FILE__
