module ApplicationHelper
  def maximum_entrant_id_of(rank)
    count = Player.where(rank_code: rank).count
    if count == 0
      0
    elsif count <= Settings.quota[rank]
      Player.where(rank_code: rank).last.id
    else
      Player.offset(Settings.quota[rank] - 1).where(rank_code: rank).first.id
    end
  end
end
