class Player < ApplicationRecord
  belongs_to :team

  validates :last_name,       presence: true, length: { maximum: 30 }
  validates :first_name,      presence: true, length: { maximum: 30 }
  validates :last_name_kana,  presence: true, length: { maximum: 50 }, format: { with: /\A\p{Hiragana}+\z/ }
  validates :first_name_kana, presence: true, length: { maximum: 50 }, format: { with: /\A\p{Hiragana}+\z/ }
  validates :rank_code,       presence: true,                          format: { with: /\A[C-E]\z/ }
  validates :team_id,         presence: true
end
