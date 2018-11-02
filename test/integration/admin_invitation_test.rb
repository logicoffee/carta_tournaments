require 'test_helper'

class AdminInvitationTest < ActionDispatch::IntegrationTest
  def setup
    # 送信メールのリセット
    ActionMailer::Base.deliveries.clear

    # すでに存在する管理者でログイン
    @admin = admins(:ryo)
    admin_sign_in_as @admin
  end

  test "invitation flow" do
    # メンバーの招待
    get new_admin_invitation_path
    inv_email = "foo@example.com"
    assert_difference 'Invitation.count', 1 do
      post admin_invitations_path, params: {
        invitation: {
          email: inv_email
        }
      }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to admin_root_url
    assert flash[:success].present?
    token = assigns(:invitation).invitation_token

    # 招待された側の処理をテストするためにログアウト
    admin_sign_out

    # 管理者登録
    get admin_new_sign_up_path(token, email: inv_email)
    assert_response :success
    assert_difference 'Admin.count', 1 do
      post admin_sign_up_path(token, email: inv_email), params: {
        admin: {
          name: "招待された管理者",
          email: inv_email,
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    assert admin_is_signed_in?
  end
end
