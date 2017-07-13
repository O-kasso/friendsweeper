class Usernames
  class << self
    def prepare
      prompt_for_usernames
    end

    private

    def prompt_for_usernames
      puts 'What is your Facebook username? For more information on what a Facebook username is, visit https://www.facebook.com/username'
      @@my_username = gets.chomp

      puts 'What is your former friend\'s Facebook username?'
      @@friend_username = gets.chomp
      confirm_usernames
    end

    def confirm_usernames
      puts "Your Facebook username is #{@@my_username}. The friend you wish to erase has this username: #{@@friend_username}."
      puts 'Is this correct? [y/N] '
      input = STDIN.getch.downcase
      if input == 'y'
        export_usernames
      else
        abort('Aborting...')
      end
    end

    def export_usernames
      ENV['my_username'] = @@my_username
      ENV['friend_username'] = @@friend_username
    end
  end
end
