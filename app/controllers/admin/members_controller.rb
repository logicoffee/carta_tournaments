class Admin::MembersController < ApplicationController
  layout 'admin'
  before_action :require_invitation_token

  def new
  end

  private
    def require_invitation_token
      @quasi_admin = Admin.find_by(email: params[:email], signed_up: false)
      unless @quasi_admin && BCrypt::Password.new(@quasi_admin.invitation_digest) == params[:id]
        flash[:danger] = "不正なURLです"
        redirect_to root_url
      end
    end
end
