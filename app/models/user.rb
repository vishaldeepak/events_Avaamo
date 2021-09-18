class User < ApplicationRecord
  validates :username,
    presence: true,
    uniqueness: true

  has_many :user_events, primary_key: :username

  has_many :events, through: :user_events

end
