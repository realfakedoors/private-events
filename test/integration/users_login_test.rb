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
end