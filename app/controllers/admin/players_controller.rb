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

    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: 'kyoto_c.csv', type: :csv
      end
    end
  end
end
