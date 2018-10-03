class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def index
  end

  private
  
    def require_sign_in_as_admin
      unless admin_signed_in?
        flash[:danger] = "管理者権限がありません"
        redirect_to root_url
      end
    end
end
