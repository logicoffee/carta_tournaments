class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def index
    @all_players = KyotoRank::RankData.ranks.map do |rank|
      Player.where(rank_code: rank).order(:created_at)
    end

    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: 'kyoto_c.csv', type: :csv
      end
    end
  end
end
