require 'yaml'

namespace :tournament do
  desc "insert tournament classes"
  task create_classes: :environment do
    default_tournament = Tournament.first

    tournament_classes = YAML.load_file(File.dirname(__FILE__) + "/tournament_classes.yml")
    tournament_classes.map do |tournament_class|
      default_tournament.tournament_classes << TournamentClass.new(tournament_class)
    end
  end
end