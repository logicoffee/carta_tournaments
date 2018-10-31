ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def sign_in_as(team, password: "password")
    post sign_in_path, params: {
      email: team.email,
      password: password
    }
  end

  def is_signed_in?
    session[:team_id].present?
  end

  def admin_sign_in_as(admin, password: "password")
    post admin_sign_in_path, params: {
      email: admin.email,
      password: password
    }
  end

  def admin_is_signed_in?
    session[:admin_id].present?
  end

  def admin_sign_out
    session.delete(:admin_id)
  end
end
