class Team < ApplicationRecord
  has_many :players
  has_secure_password
  attr_accessor :activation_token
  before_save :downcase_email
  before_create :create_activation_digest

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

    def create_activation_digest
      self.activation_token  = SecureRandom.urlsafe_base64
      self.activation_digest = BCrypt::Password.create(activation_token)
    end
end
