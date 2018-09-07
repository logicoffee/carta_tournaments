class TeamsController < ApplicationController
  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "新規かるた会登録が完了しました"
      redirect_to team_path(@team)
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
