class SessionsController < ApplicationController
  def new
  end

  def create
    team = Team.find_by(email: params[:email])
    if team && team.authenticate(params[:password]) && team.activated?
      sign_in team
      redirect_to team_url
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくないか、アカウントの有効化が完了していません。"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
