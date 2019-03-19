require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:morty)
  end
  
  test 'display links in header bar' do
    get login_path
    post login_path, params: { session: { name: @user.name } }
    assert_redirected_to @user
    follow_redirect!
    
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a',         "Events"
    assert_select 'a',         "Invitations"
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
