class Invitation < ApplicationRecord
  belongs_to :tournament
  attr_accessor :invitation_token
  before_create :create_invitation_digest

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  private
    def create_invitation_digest
      self.invitation_token  = SecureRandom.urlsafe_base64
      self.invitation_digest = BCrypt::Password.create(invitation_token)
    end
end
