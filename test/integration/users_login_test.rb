require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  include SessionsHelper
  
  def setup
    @user = users(:morty)
  end
  
  test 'users can log in' do
    post login_path, params: { session: { name: @user.name } }
    assert_equal current_user.id, @user.id
  end
  
  test 'users can log out' do
    post login_path, params: { session: { name: @user.name } }
    delete logout_path
    assert_nil session[:user_id]
    assert_not logged_in?
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