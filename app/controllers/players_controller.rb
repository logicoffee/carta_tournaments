class PlayersController < ApplicationController
  before_action :require_sign_in

  def new
    @player     = Player.new
    @tournament = Tournament.find(params[:tournament_id])
  end

  def create
    @player          = current_team.players.build(player_params)
    @tournament      = Tournament.find(params[:tournament_id])
    tournament_class = TournamentClass.find(params[:tournament_class_id])

    begin
      Player.transaction do
        @player.save!
        tournament_class.players << @player
      end 
      flash[:success] = "登録が完了しました"
      redirect_to team_url
    rescue
      render :new
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(player_params)
      flash[:success] = "選手情報を更新しました"
      redirect_to team_url
    else
      render :edit
    end
  end

  def destroy
    player = Player.find_by!(id: params[:id], team_id: session[:team_id])

    if player.deleted?
      flash[:danger] = "すでに申込がキャンセルされています"
    else
      player.delete_logically
      flash[:success] = "申込を1件キャンセルしました"
    end
    redirect_to team_url
  end

  private
    def player_params 
      params.require(:player).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :rank)
        .merge(extra_attributes: params[:player][:extra_attributes].to_json)
    end
end
