class Event < ApplicationRecord
  validates_presence_of :title,
   :starttime,
   :endtime
end
