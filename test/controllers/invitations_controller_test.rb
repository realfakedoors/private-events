require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @host       =       users(:rick)
    @guest      =       users(:morty)
    @invitation = invitations(:rickinvitesmortytoswapmeet)
    @event      =      events(:swapmeet)
  end
  
  test "should get new" do
    get new_invitation_url, params: { event: { attended_event_id: @event.id } }
    assert_response :success
    assert_select "h1", "Invite people to your event!"
  end
  
  test "redirect to event#show upon creation" do
    log_in_as(@host)
    post invitations_url, params: { invitation: { attended_event_id: @event.id, guest_id: [@guest.id] } }
    assert_redirected_to event_path(@event)
  end
  
  test "should create new invitations for each guest in guest_id" do
    log_in_as(@host)
    assert_difference 'Invitation.count', 3 do
      post invitations_url, params: { invitation: { attended_event_id: @event.id, guest_id: [1, 2, 3] } }
    end
  end
  
  test "the event's host should be the only one able to create invitations" do
    log_in_as(@guest)
    post invitations_url, params: { invitation: { attended_event_id: @event.id, guest_id: [@guest.id] } }
    assert_redirected_to root_url
  end
  
  test "a guest should be able to accept or decline an invitation" do
    log_in_as(@guest)
    post accept_url, params: { event: @event.id, guest: @guest.id }
    assert Invitation.find(@invitation.id).accepted?
    
    assert_difference 'Invitation.count', -1 do
      post decline_url, params: { event: @event.id, guest: @guest.id }
    end
  end
  
end