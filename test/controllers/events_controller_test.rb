require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @event = events(:swapmeet)
    @user = users(:rick)
  end
  
  test "should get new, show, and index" do
    get new_event_url
    assert_response :success
    assert_select "h1", "Host an event"
    get event_url(@event)
    assert_response :success
    assert_select "h1", "swapmeet"
    get events_url
    assert_response :success
    assert_select "h1", "All Events"
  end
  
  test "should get edit when logged in" do
    log_in_as(@user)
    get edit_event_url(@event)
    assert_response :success
  end
  
  test "a logged-in user should be able to update or destroy an event" do
    log_in_as(@user)
    assert_nothing_raised do
      patch event_url(@event), params: { event: { name: "Crunch City", location: "Battle Creek, MI", 
        datetime: DateTime.now, host: @user } }
    end
    assert_difference "Event.count", -1 do
      delete event_url(@event)
    end
  end
  
  test "should redirect when attempting to edit, update or destroy while not logged in" do
    get edit_event_url(@event)
    assert_redirected_to root_url
    patch event_url(@event), params: { event: { name: "x", location: "y",
      datetime: DateTime.now, host: @user}}
    assert_redirected_to root_url
    delete event_url(@event)
    assert_redirected_to root_url
  end
  
  test "a logged-in user should be able to create an event with proper parameters" do
    log_in_as(@user)
    assert_difference "Event.count", 1 do
      post events_url, params: { event: { name: "Trap Trap Trap", location: "Atlanta, GA",
        datetime: DateTime.now, host_id: 1 } }
    end
  end
  
  test "should fail to save or update an event without the right parameters" do
    assert_no_difference "Event.count" do
      post events_url, params: { event: { name: "SremmLife" } }
      patch event_url(@event), params: { event: { name: "SremmWorld" } }
    end
  end
  
  test "should remove an event on destroy" do
    log_in_as(@user)
    assert_difference "Event.count", -1 do
      @event.destroy
    end
    
    assert_raises(ActiveRecord::RecordNotFound) do
      get event_path(@event)
    end
  end
  
end