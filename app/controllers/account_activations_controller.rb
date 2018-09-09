class AccountActivationsController < ApplicationController
  def activate
    team = Team.find_by(email: params[:email])
    if team && !team.activated? && BCrypt::Password.new(team.activation_digest) == params[:id]
      team.update_columns(activated: true, activated_at: Time.zone.now)
      sign_in team
      redirect_to team_url
    else
      flash[:danger] = "不正なアカウント有効化URLです"
      redirect_to root_url
    end
  end
end
