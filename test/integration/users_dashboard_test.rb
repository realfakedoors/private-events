require 'test_helper'

class UsersDashboardTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:morty)
    log_in_as(@user)
  end
  
  test 'display links in header bar' do
    assert_redirected_to dashboard_path
    follow_redirect!
    
    assert_template 'users/dashboard'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a',         "Profile"
    assert_select 'a',         "Dashboard"
    assert_select 'a',         "All Events"
    assert_select 'a[href=?]', logout_path
  end
  
  test 'display invites received, past and upcoming events' do
    follow_redirect!
    
    assert_select 'h2', "My Past Events"
    assert_select 'h2', "My Upcoming Events"
    assert_select 'h2', "Invites Received"
    assert_select 'h2', "Events I'm Attending"
  end
end
