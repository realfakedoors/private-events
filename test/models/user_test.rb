require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:rick)
    @event = events(:swapmeet)
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name shouldn't be blank" do
    @user.name = "        "
    assert_not @user.valid?
  end
  
  test "a deleted user's hosted events should be destroyed" do
    @event.save
    assert_difference 'Event.count', -1 do
      @user.destroy
    end
  end
  
end