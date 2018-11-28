class StaticPagesController < ApplicationController
  def home
  end

  def info
    @tournament = Tournament.includes(:tournament_classes).first
  end
end
