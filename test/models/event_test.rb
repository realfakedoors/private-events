require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  def setup
    @event = events(:brickcity)
    @past_event = events(:dinoextinction)
    @future_event = events(:jetsoncars)
  end
  
  test "events should abide by two scopes based on datetime: past and future" do
    assert_includes Event.all.past,   @past_event
    assert_includes Event.all.future, @future_event
  end
  
  test "all events should be sorted by datetime" do
    datetimes = Event.all.collect {|e| e.datetime}
    assert_equal datetimes, datetimes.sort
  end
  
  test "event should be valid with proper parameters" do
    assert Event.new(name: "Junebug Stomping", location: "Peachtree St", datetime: DateTime.new(2019,6,6,14)).valid?
  end
  
  test "shouldn't be able to save with a name that's already in use" do
    assert_no_difference "Event.count" do
      Event.new(name: "brickcity", location: "123 Sesame Street", datetime: DateTime.now).save
    end
  end
  
  test "name shouldn't be blank" do
    @event.name = "      "
    assert_not @event.valid?
  end
  
  test "location shouldn't be blank" do
    @event.location = "      "
    assert_not @event.valid?
  end
  
  test "datetime should be a valid Time object" do
    assert_equal @event.datetime.class, ActiveSupport::TimeWithZone
  end
  
end