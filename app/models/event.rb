class Event < ApplicationRecord
  validates_presence_of :title,
   :starttime,
   :endtime

   has_many :user_events
end
