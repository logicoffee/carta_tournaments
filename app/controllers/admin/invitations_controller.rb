class Admin::InvitationsController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def new
    @invitation = current_tournament.invitations.build
  end

  def create
    @invitation = current_tournament.invitations.build(invitation_params)

    if @invitation.save
      Admin::MemberMailer.invitation_email(@invitation).deliver_now
      flash[:success] = "招待メールを送信しました"
      redirect_to admin_root_url
    else
      render :new
    end
  end

  private
    def invitation_params
      params.require(:invitation).permit(:email)
    end
end
