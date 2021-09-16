class User < ApplicationRecord
  validates :username,
    presence: true,
    uniqueness: true

  has_many :user_events

  has_many :events, through: :user_events

end
