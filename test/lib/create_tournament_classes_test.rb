require 'test_helper'
require 'yaml'

class CreateTournamentClassesTest < ActionDispatch::IntegrationTest
  def setup
    Myapp::Application.load_tasks
    @default_tournament = tournaments(:shiga)
    @count = YAML.load_file(Rails.root.to_s + '/lib/tasks/tournament_classes.yml').count
  end

  test "tournament classes creation" do
    assert_difference '@default_tournament.tournament_classes.count', @count do
      Rake::Task['tournament:create_classes'].invoke
    end
  end
end
