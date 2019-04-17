require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  def setup
    @rick = users(:rick)
    @morty = users(:morty)
    @event = events(:swapmeet) # hosted by rick
    @invitation = invitations(:rickinvitesmortytoswapmeet)
  end
  
  test "an invitation should belong to both its event and guest" do
    assert_equal @invitation.event, @event
    assert_equal @invitation.guest, @morty
  end
  
  test "a deleted event's invitations should be destroyed" do
    assert_difference 'Invitation.count', -1 do
      @event.destroy
    end
  end
  
  test "the 'accepted' attribute is false by default" do
    assert_not @invitation.accepted?
  end
  
end
