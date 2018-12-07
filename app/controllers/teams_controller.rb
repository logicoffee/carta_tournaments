class TeamsController < ApplicationController
  include ApplicationHelper
  before_action :require_sign_in, only: %i[show]

  def show
    @tournament = default_tournament

    # 出場人数が0であるtournament_classも取得するためにteam_idとdeletedにnilを指定している
    @tournament_classes = TournamentClass
      .includes(:players)
      .where(
        tournament_id: @tournament.id,
        players: {
          team_id: [ current_team.id, nil ],
          deleted: [ false, nil ]
        }
      )
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
