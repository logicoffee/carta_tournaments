class Admin::SessionsController < ApplicationController
  layout 'admin'

  def new
  end

  def create
    @admin = Admin.find_by(email: params[:email])
    if @admin && @admin.authenticate(params[:password])
      admin_sign_in @admin
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render :new
    end
  end
end
