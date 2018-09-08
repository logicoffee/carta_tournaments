module SessionsHelper
  def sign_in(team)
    session[:team_id] = team.id
  end
end
