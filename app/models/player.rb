class Player < ApplicationRecord
  belongs_to :team

  validates :rank_code,       presence: true,                          format: { with: /\A[C-E]\z/ }
  validates :team_id,         presence: true
  validate  :full_name_should_be_present, :full_name_kana_should_be_present,
            :full_name_should_have_maximum_length, :full_name_kana_should_have_maximum_length,
            :full_name_kana_should_be_hiragana

  def full_name
    last_name + ' ' + first_name
  end

  def delete_logically
    update_attribute(:deleted, true)
  end

  private
    def full_name_should_be_present
      if last_name.blank? || first_name.blank?
        errors.add(:full_name, "を入力してください")
      end
    end

    def full_name_kana_should_be_present
      if last_name_kana.blank? || first_name_kana.blank?
        errors.add(:full_name_kana, "を入力してください")
      end
    end

    def full_name_should_have_maximum_length
      if last_name.length > 30 || first_name.length > 30
        errors.add(:full_name, "は30文字以内で入力してください")
      end
    end

    def full_name_kana_should_have_maximum_length
      if last_name_kana.length > 50 || first_name_kana.length > 50
        errors.add(:full_name_kana, "は50文字以内で入力してください")
      end
    end

    def full_name_kana_should_be_hiragana
      if last_name_kana !~ /\A\p{Hiragana}+\z/ || first_name_kana !~ /\A\p{Hiragana}+\z/
        errors.add(:full_name_kana, "はひらがなで入力してください")
      end
    end
end
