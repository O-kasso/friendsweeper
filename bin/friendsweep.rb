#!/usr/bin/env ruby

require 'rubygems'
require 'commander'
require 'io/console'
require_relative '../lib/pages/friendship'
require_relative '../lib/session/session'

class FriendSweeper
  include Commander::Methods
  include Session

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


        friendship_page = FriendshipPage.new
        # TODO take out test values
        friendship_page.load(user: username, friend: friend_username)
        sleep 12

        begin
          friendship_page.delete_all_visible_stories
        rescue Exception => e
          puts e
        end
      end
    end

    run!
  end
end

FriendSweeper.new.run if $0 == __FILE__
