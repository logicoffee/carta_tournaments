module ApplicationHelper
  def this_tournament
    @tournament ||= Tournament.first
  end
end
