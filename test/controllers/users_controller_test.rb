require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:rick)
  end
  
  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should get show" do
    get user_url(@user)
    assert_response :success
  end
  
  test "should delete a user properly on destroy" do
    @user.save
    
    assert_difference "User.count", -1 do
      @user.destroy
    end
    
    assert_raises(ActiveRecord::RecordNotFound) do
      get user_path(@user)
    end
  end

end
