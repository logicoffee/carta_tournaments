require 'test_helper'

class AdminPlayersListsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = admins(:ryo)
    admin_sign_in_as @admin
    @tournament_class = tournament_classes(:advanced_class)
    @player = players(:advanced_player)
  end

  test "players list" do
    get admin_root_path
    assert_select 'td', text: @player.full_name

    get admin_root_path(tournament_class_id: @tournament_class.id, format: :csv)
    assert_equal 'text/csv', response.headers["Content-Type"]
  end
end
