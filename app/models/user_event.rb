class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :rsvp,
    presence: true

  enum rsvp: {
    maybe: 0,
    no: 1,
    yes: 2
  }
end
