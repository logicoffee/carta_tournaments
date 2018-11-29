require 'test_helper'

class CreateTournamentClassesTest < ActionDispatch::IntegrationTest
  def setup
    Myapp::Application.load_tasks
    @default_tournament = tournaments(:shiga)
  end

  test "tournament classes creation" do
    initial_count = @default_tournament.tournament_classes.count
    Rake::Task['tournament:create_classes'].invoke
    assert @default_tournament.tournament_classes.count > initial_count
  end
end