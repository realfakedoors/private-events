require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:morty)
  end
  
  test 'display links in header bar' do
    get login_path
    log_in_as(@user)
    assert_redirected_to dashboard_path
    follow_redirect!
    
    assert_template 'users/dashboard'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a',         "Profile"
    assert_select 'a',         "Dashboard"
    assert_select 'a[href=?]', logout_path
  end
  
  test 'only display login link if not logged in' do
    get user_path(@user)
    
    assert_select 'a[href=?]', login_path
    
    assert_select 'a[href=?]', user_path(@user), count: 0
    assert_select 'a[href=?]', logout_path,      count: 0    
    assert_select 'a', {count: 0, text: "Events"}
    assert_select 'a', {count: 0, text: "Invitations"}    
  end
end
