class UserEvent < ApplicationRecord
  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :username

  belongs_to :event

  validates :rsvp,
    presence: true

  enum rsvp: {
    maybe: 0,
    no: 1,
    yes: 2
  }
end
