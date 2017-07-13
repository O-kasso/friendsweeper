class FriendshipPage < WatirDrops::PageObject
  page_url { "https://www.facebook.com/friendship/#{ENV['my_username']}/#{ENV['friend_username']}/" }

  element(:feed) { browser.div(css: "[role='feed']") }
  element(:story) { feed.div(css: "[role='article']") }
  element(:story_options) { story.a(css: "[aria-label='Story options']") }
  element(:story_options_menu) { browser.ul(css: "[role='menu']") }
  element(:story_delete_option) do
    story_options_menu.li(css: "[data-feed-option-name='FeedDeleteOption']")
  end
  element(:overlay_footer) { browser.div(class: 'uiOverlayFooter') }
  element(:confirm_delete_btn) do
    overlay_footer.button(class: 'layerConfirm uiOverlayButton')
  end

  def open_story_menu
    story_options.click
  end

  def delete_story
    story_delete_option.click
    overlay_footer.wait_until_present
    confirm_delete_btn.click
  end
end
