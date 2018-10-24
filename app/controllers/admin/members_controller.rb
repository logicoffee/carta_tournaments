class Admin::MembersController < ApplicationController
  layout 'admin'
  before_action :require_invitation_token

  def new
  end

  private
    def require_invitation_token
      @signing_up_admin = Admin.find_by(email: params[:email], signed_up: false)
      unless @signing_up_admin && BCrypt::Password.new(@signing_up_admin.invitation_digest) == params[:id]
        flash[:danger] = "不正なURLです"
        redirect_to root_url
      end
    end
end
