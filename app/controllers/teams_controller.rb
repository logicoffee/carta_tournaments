class TeamsController < ApplicationController
  include ApplicationHelper
  before_action :require_sign_in, only: %i[show]

  def show
    @tournament = default_tournament

    # 出場人数が0であるtournament_classも取得するためにteam_idとdeletedにnilを指定している
    @tournament_classes = TournamentClass
      .eager_load(:players)
      .find_and_order_by_id(tournament_id: @tournament.id)
      .merge(Player.default_query(admin: false, team_id: current_team.id))
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
