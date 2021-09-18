class Event < ApplicationRecord
  validates_presence_of :title,
   :starttime,
   :endtime

   has_many :user_events, dependent: :destroy

   scope :with_user_attending, -> (user) {
     joins(:user_events)
     .where("user_events.user_id = ?", user.username)
     .where("user_events.rsvp = 2")
   }

   scope :between_dates, -> (starttime, endtime) {
    where("(?,?) OVERLAPS (starttime, endtime)", starttime, endtime)
   }

end
