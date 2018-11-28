module ApplicationHelper
  def default_tournament
    @tournament ||= Tournament.first
  end
end
