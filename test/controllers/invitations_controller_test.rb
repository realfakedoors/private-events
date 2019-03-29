require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:rick)
  end
  
  test "should get new" do
    get new_invitation_path
    assert_response :success
  end
  
  test "should create new invitations for each guest" do
    assert_difference 'Invitation.count', 3 do
      post invitations_url, params: { invitation: { host_id: 1, attended_event_id: 1, guest_ids: "1, 2, 3" } }
    end
  end      
  
end