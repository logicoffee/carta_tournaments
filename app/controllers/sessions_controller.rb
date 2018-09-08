class SessionsController < ApplicationController
  def new
  end

  def create
    team = Team.find_by(email: params[:email])
    if team && team.authenticate(params[:password])
      session[:team_id] = team.id
      redirect_to team_path
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render 'new'
    end
  end
end
