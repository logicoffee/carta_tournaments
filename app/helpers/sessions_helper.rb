module SessionsHelper
  def sign_in(team)
    session[:team_id] = team.id
  end

  def signed_in?
    !session[:team_id].nil?
  end
end
