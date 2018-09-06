class Team < ApplicationRecord
  has_secure_password
  before_save :downcase_email

  validates :name,     presence: true, length: { maximum:  50 }
  validates :leader,   presence: true, length: { maximum:  50 }
  validates :email,    presence: true, length: { maximum: 255 },
                       uniqueness: { case_sensitive: false },
                       format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum:   8 }

  private
    def downcase_email
      self.email.downcase!
    end
end