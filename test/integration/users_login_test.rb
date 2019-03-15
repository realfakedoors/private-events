require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:morty)
  end
  
  test 'users can log in' do
    post login_path, params: { session: { name: @user.name } }
    assert_equal session[:user_id], @user.id
  end
  
  test 'users can log out' do
    post login_path, params: { session: { name: @user.name } }
    delete logout_path
    assert_nil session[:user_id]
  end
end
