class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def index
    @tournament_classes = TournamentClass
      .eager_load(:players)
      .find_and_order_by_id(
        tournament_id: current_tournament.id,
        tournament_class_id: params[:tournament_class_id]
      )
      .merge(Player.default_query(admin: true))

    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: 'players.csv', type: :csv
      end
    end
  end
end
