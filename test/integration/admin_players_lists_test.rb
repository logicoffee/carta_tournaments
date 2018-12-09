require 'test_helper'

class AdminPlayersListsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = admins(:ryo)
    admin_sign_in_as @admin
    @player = players(:advanced_player)
  end

  test "players list" do
    get admin_root_path
    assert_select 'td', text: @player.full_name
  end
end
