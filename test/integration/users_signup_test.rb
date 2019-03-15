require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:rick)
  end
  
  test "sign up as a new user" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: @user.name } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end