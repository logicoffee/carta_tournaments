class Tournament < ApplicationRecord
  has_many :invitations
  has_many :admins
  has_many :tournament_classes
end
