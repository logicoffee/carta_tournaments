module SessionsHelper
  def sign_in(team)
    session[:team_id] = team.id
  end

  def signed_in?
    !session[:team_id].nil?
  end

  def current_team
    @current_team ||= Team.find_by(id: session[:team_id])
  end
end
