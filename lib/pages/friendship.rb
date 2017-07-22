require_relative './base_page'

class FriendshipPage < BasePage
  def initialize(user, friend)
    @user = user
    @friend = friend
    @url = "https://www.facebook.com/friendship/#{@user}/#{@friend}"
  end

  def launch
    visit @url
  end

  def delete_latest_story
    delete_story(latest_story)
  end

  def delete_all_visible_stories
    visible_stories.each do |s|
      delete_story(s)
      byebug
    end
  end

  private

  def feed
    first("div[role='feed']", wait: 10)
  end

  def latest_story
    within feed do
      first "div[role='article']"
    end
  end

  def visible_stories
    within feed do
      all "div[role='article']"
    end
  end

  def story_option_button
    find_link 'Story options'
  end

  def story_option_menu
    find "ul[role='menu']"
  end

  def delete_option
    within story_option_menu do
      find "a[data-feed-option-name='FeedDeleteOption']"
    end
  end

  def confirm_delete_button
    within 'div.uiOverlayFooter' do
      find 'button.layerConfirm.uiOverlayButton'
    end
  end

  def delete_story(story)
    open_story_options(story)
    delete_option.click
    confirm_delete_button.click
    byebug
  end

  def open_story_options(story)
    within story do
      story_option_button.click
    end
  end
end
