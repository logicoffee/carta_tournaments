class Team < ApplicationRecord
  has_many :players
  has_secure_password
  attr_accessor :activation_token
  before_create :create_activation_digest

  validates :name,     presence: true, length: { maximum:  50 }
  validates :leader,   presence: true, length: { maximum:  50 }
  validates :email,    presence: true, length: { maximum: 255 },
                       uniqueness: true,
                       format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum:   8 }

  private
    def create_activation_digest
      self.activation_token  = SecureRandom.urlsafe_base64
      self.activation_digest = BCrypt::Password.create(activation_token)
    end
end
