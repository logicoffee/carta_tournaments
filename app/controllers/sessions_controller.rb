class SessionsController < ApplicationController
  def new
  end

  def create
    team = Team.find_by(email: params[:email])
    if team && team.authenticate(params[:password])
      if team.activated?
        sign_in team
        redirect_to team_url
      else
        flash[:warning] = "メールを確認し, アカウントの有効化を完了してください"
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render 'new'
    end
  end
end
