class PlayersController < ApplicationController
  before_action :require_sign_in
  before_action :require_appropriate_rank, only: %i[new create]

  def new
    @players = []
    3.times do 
      @players << Player.new
    end
  end

  def create
    @team = current_team
    @players = players_params[:players].reject do |player_params|
      all_empty?(player_params)
    end.map do |player_params|
      player_params[:team_id]   = @team.id
      player_params[:rank_code] = @rank
      Player.new(player_params)
    end

    @error_messages = @players.inject([]) do |result, player|
      player.valid?
      result | player.errors.full_messages
    end

    if @error_messages.empty?
      @players.each(&:save)
      flash[:success] = "申込が完了しました"
      redirect_to team_url
    else
      render 'new'
    end
  end

  private
    def team_params
      params.require(:team)
        .permit(players_attributes: [:team_id, :last_name, :first_name, :last_name_kana, :first_name_kana, :rank_code])
    end

    def players_params
      params.permit(players: [:last_name, :first_name, :last_name_kana, :first_name_kana, :rank_code])
    end

    def require_appropriate_rank
      unless KyotoRank::RankData.ranks.include?(params[:rank].to_sym)
        throw ActiveRecord::RecordNotFound
      end
      @rank = params[:rank]
    end

    def all_empty?(hash)
      hash.values.inject(true) do |valid, value|
        valid &= value.empty?
      end
    end
end
