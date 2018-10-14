module Admin::SessionsHelper
  def admin_sign_in(admin)
    session[:admin_id] = admin.id
  end

  def admin_signed_in?
    !session[:admin_id].nil?
  end

  def admin_sign_out
    session.delete(:admin_id)
  end
end
