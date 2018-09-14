module ApplicationHelper
  def maximum_entrant_id_of(rank)
    Player.offset(Settings.quota[rank] - 1).first.id
  end
end
