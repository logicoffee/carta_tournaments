class Admin::MembersController < ApplicationController
  layout 'admin'
  before_action :require_invitation_token

  def new
  end

  private
    def require_invitation_token
      invitation = Invitation.find_by(email: params[:email], signed_up: false)
      unless invitation && BCrypt::Password.new(invitation.invitation_digest) == params[:id]
        flash[:danger] = "不正なURLです"
        redirect_to root_url
      end
    end
end
