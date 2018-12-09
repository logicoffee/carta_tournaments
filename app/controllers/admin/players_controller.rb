class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def index
    @tournament_classes = TournamentClass
      .includes(:players)
      .where(
        tournament_id: current_tournament.id,
        players: { deleted: [ false, nil ] }
      )

    # CSV用の変数
    @players = Player
      .joins(:tournament_classes)
      .where(
        deleted: false,
        tournament_classes: {
          id: params[:tournament_class_id]
        }
      )

    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: 'players.csv', type: :csv
      end
    end
  end
end
