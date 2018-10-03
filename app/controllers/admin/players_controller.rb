class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def index
    @all_players = KyotoRank::RankData.ranks.map do |rank|
      Player.where(rank_code: rank).order(:created_at).limit(Settings.quota[rank])
    end
  end

  private
  
    def require_sign_in_as_admin
      unless admin_signed_in?
        flash[:danger] = "管理者権限がありません"
        redirect_to root_url
      end
    end
end
