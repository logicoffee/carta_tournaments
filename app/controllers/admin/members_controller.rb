class Admin::MembersController < ApplicationController
  layout 'admin'
  before_action :require_invitation_token

  def new
    @admin = Admin.new(email: params[:email])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      @invitation.update_attribute(:signed_up, true)
      admin_sign_in @admin
      flash[:success] = "管理者登録が完了しました"
      redirect_to admin_root_url
    else
      render :new
    end
  end

  private
    def require_invitation_token
      @invitation = Invitation.find_by(email: params[:email], signed_up: false)
      unless invitation && BCrypt::Password.new(@invitation.invitation_digest) == params[:id]
        flash[:danger] = "不正なURLです"
        redirect_to root_url
      end
    end

    def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end
end
