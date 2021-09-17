class UserEvent < ApplicationRecord
  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :username

  validates :user_id, uniqueness: { scope: :event_id }  #Add unique index

  belongs_to :event

  validates :rsvp,
    presence: true

  enum rsvp: {
    maybe: 0,
    no: 1,
    yes: 2
  }
end
