require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @event = events(:swapmeet)
    @user = users(:rick)
  end
  
  test "should get new" do
    get new_event_url
    assert_response :success
  end
  
  test "should get show" do
    get event_url(@event)
    assert_response :success
  end
  
  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end
  
  test "should create an event with proper parameters" do
    assert_difference "Event.count", 1 do
      post events_url, params: { event: { name: "Trap Trap Trap", location: "Atlanta, GA", datetime: DateTime.now, host_id: 1 } }
    end
  end
  
  test "should fail to save an event without the right parameters" do
    assert_no_difference "Event.count" do
      post events_url, params: { event: { name: "SREMMLIFE" } }
    end
  end
  
  test "should remove an event on destroy" do
    @event.save
    
    assert_difference "Event.count", -1 do
      @event.destroy
    end
    
    assert_raises(ActiveRecord::RecordNotFound) do
      get event_path(@event)
    end
  end
  
end