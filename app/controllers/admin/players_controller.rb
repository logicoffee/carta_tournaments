class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def index
    @tournament_classes = TournamentClass
      .includes(:players)
      .find_by_tournament_class_id(params[:tournament_class_id])
      .where(
        tournament_id: current_tournament.id,
        players: { deleted: [ false, nil ] }
      )

    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: 'players.csv', type: :csv
      end
    end
  end
end
