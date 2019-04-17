require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:rick)
    @event = events(:swapmeet) # hosted by rick
  end
  
  test "should be valid with the right parameters" do
    assert User.new(name: "Brooks Koepka").valid?
  end
  
  test "name shouldn't be blank" do
    @user.name = "        "
    assert_not @user.valid?
  end
  
  test "a deleted user's hosted events should be destroyed" do
    assert_difference 'Event.count', -3 do
      @user.destroy
    end
  end
  
end