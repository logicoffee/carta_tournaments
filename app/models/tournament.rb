class Tournament < ApplicationRecord
  has_many :invitations
  has_many :admins
end
