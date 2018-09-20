class TeamsController < ApplicationController
  before_action :require_sign_in, only: %i[show]

  def show
    @team = current_team
    @entry_lists = KyotoRank::RankData.ranks.map do |rank|
      Player.joins(:team).where(teams: { id: @team.id }, rank_code: rank, deleted: false)
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:info] = "アカウントの仮登録が完了しました. メールを確認してください."
      TeamMailer.account_activation(@team).deliver_now
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  private
    def team_params
      params.require(:team).permit(:name, :leader, :email, :password, :password_confirmation)
    end
end
