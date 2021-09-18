class EventsController < ApplicationController
  before_action :set_date_from_select
  def events
    @events = Event.between_dates(@starttime, @endtime)
  end
end
