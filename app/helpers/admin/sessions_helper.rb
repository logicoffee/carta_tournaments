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

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  def current_tournament
    @current_tournament ||= current_admin.tournament
  end
end
