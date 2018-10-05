class ApplicationController < ActionController::Base
  include SessionsHelper
  include Admin::SessionsHelper
  protect_from_forgery with: :exception

  private
    def require_sign_in
      unless signed_in?
        flash[:danger] = "ログインしてください"
        redirect_to sign_in_url
      end
    end

    def require_sign_in_as_admin
      unless admin_signed_in?
        flash[:danger] = "管理者権限がありません"
        redirect_to root_url
      end
    end
end
