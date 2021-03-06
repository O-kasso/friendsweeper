require 'capybara/dsl'
require 'site_prism'

class FriendshipPage < SitePrism::Page
  set_url "/friendship{/user}{/friend}"

  element :main, ".fb_content[role='main']"
  elements :story_group, "[role='feed']"
  elements :stories, "[role='article']"
  element :story_options_menu, :xpath, "//ul[@role='menu']"
  element :delete_option, "a[data-feed-option-name='FeedDeleteOption']"
  element :confirm_delete_button,
          :xpath,
          "//button[contains(@class, 'layerConfirm')]"

  def delete_latest_story
    within story_group.first do
      delete_story(stories.first)
    end
  end

  def delete_all_visible_stories
    wait_for_story_group

    story_group.each do |sg|
      within sg do
        stories.each do |s|
          delete_story(s)
        end
      end
    end
  end

  private

  def delete_story(story)
    open_story_options(story)

    wait_for_story_options_menu

    within story_options_menu do
      delete_option.click
    end

    wait_for_confirm_delete_button
    confirm_delete_button.click

    # lazy workaround to wait for AJAX to finish
    sleep 1
    puts 'Deleted a story.'
  end

  def open_story_options(story)
    return true if has_story_options_menu?

    within story do
      # using aria-label
      find_link('Story options').click
    end
  end
end
