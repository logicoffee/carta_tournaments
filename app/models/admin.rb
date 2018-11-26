class Admin < ApplicationRecord
  belongs_to :tournament
  has_secure_password

  validates :email,    presence: true, length: { maximum: 255 },
                       uniqueness: true,
                       format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum:   8 }
end
