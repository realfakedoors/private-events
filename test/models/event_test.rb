require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  def setup
    @event = events(:brickcity)
  end
  
  test "event should be valid" do
    assert @event.valid?
  end
  
  test "should have a unique name" do
    @event.save
    assert_no_difference "Event.count" do
      Event.new(name: "Brick City", location: "123 Sesame Street", datetime: DateTime.now).save
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