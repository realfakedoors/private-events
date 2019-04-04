require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:rick)
    @event = events(:swapmeet)
  end
  
  test "should create new invitations for each guest" do
    log_in_as(@user)
    assert_difference 'Invitation.count', 3 do
      post invitations_url, params: { invitation: { attended_event_id: @event.id, guest_ids: "1, 2, 3" } }
    end
  end      
  
end