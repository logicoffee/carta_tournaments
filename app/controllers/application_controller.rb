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
end
