#!/usr/bin/env ruby

require 'rubygems'
require 'commander'
require 'io/console'
require 'watir_drops'
require_relative '../lib/pages/friendship'

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
        ENV['my_username'] = ask 'Your Facebook username: '
        ENV['friend_username'] = ask 'Username of friend you wish to erase: '

        puts 'Launching Facebook! You have 60 seconds to login so the script can continue!'

        Watir.default_timeout = 60
        WatirDrops::PageObject.browser = Watir::Browser.new :chrome, args: [
          '--disable-notifications',
          '--disable-save-password',
          '--disable-infobars',
          '--disable-extensions'
        ]

        WatirDrops::PageObject.browser.window.maximize

        friendship_page = FriendshipPage.visit

        begin
          loop do
            friendship_page.open_story_menu
            friendship_page.delete_story
            # previously deleted story may still be cached, so wait a bit before refreshing
            sleep 3
            # refresh after deleting a story to avoid feed layout issues
            WatirDrops::PageObject.browser.refresh
          end
        rescue => e
          puts "Error: #{e}"
          puts "Either something broke, or we've successfully erased all Friendship activity! Have a good day!"
        end
      end
    end

    run!
  end
end

FriendSweeper.new.run if $0 == __FILE__
