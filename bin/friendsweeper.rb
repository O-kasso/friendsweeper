#!usr/bin/env ruby

require 'io/console'
require 'watir_drops'
require_relative '../lib/pages/friendship'
require_relative '../lib/usernames'

Usernames.prepare

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
