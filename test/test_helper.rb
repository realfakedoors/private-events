ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase

  fixtures :all
  
  def log_in_as(user)
    post login_path, params: { session: { name: user.name } }
  end
end