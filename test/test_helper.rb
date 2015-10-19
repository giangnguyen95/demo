ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  #ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  #Return true if a test user is logged in
  def is_logged_in?
  	!session[:user_id].nil?
  end 
  # Add more helper methods to be used by all tests here...
  #log in a test user
  def log_in_as(user, options={})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email: user.email,
                                  password: password,
                                  remember_me: remember_me}
    else
      session[:user_id] = user_id
    end
  end

  private

  #returns true inside an intergration test
  def integration_test?
    defined?(post_via_redirect)
  end
    
end
