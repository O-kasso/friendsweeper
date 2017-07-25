require 'spec_helper'

RSpec.describe 'FriendshipPage' do

  before :each do
    visit '/html/friendship.html'
    @page = FriendshipPage.new
  end

  feature 'Delete friendship stories' do
    scenario 'deletes the latest story in Friendship feed' do
      expect(@page.stories.count).to eq(4)
      @page.delete_latest_story
      expect(@page.stories.count).to eq(3)
    end

   scenario 'deletes all stories in Friendship feed' do
      expect(@page.stories.count).to eq(4)
      @page.delete_all_visible_stories
      expect(@page.stories.count).to be_zero
   end
  end
end
