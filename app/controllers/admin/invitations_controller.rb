class Admin::InvitationsController < ApplicationController
  layout 'admin'
  before_action :require_sign_in_as_admin

  def new
  end
end
