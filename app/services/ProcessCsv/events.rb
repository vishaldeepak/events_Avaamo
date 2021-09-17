
module ProcessCsv
  class Events
    require 'csv'
    attr_reader :file_path, :insert_limit

    def initialize(file_path: nil, insert_limit: nil)
      @file_path ||= 'public/events.csv'
      @insert_limit ||= 100 #(Vishal - Can be scaled if needed)
    end

    def call
      events = []
      CSV.foreach(Rails.root.join(file_path), headers: true).with_index do |row, index|

        if events.count == @insert_limit
          import_events events
          events=[]
        end

        event = build_event(row)

        build_user_events event, row if row['users#rsvp'].present?

        events << event

      end

      import_events events if events.any?
    end

    private

    def import_events events
      Event.import events, recursive: true, on_duplicate_key_ignore: true, validate: false
    end

    def build_user_events event, row
      event_users = row['users#rsvp'].split(";")

      event_users.each do |event_user|
        user, rsvp = event_user.split('#')
        event.user_events.build(user_id: user, rsvp: rsvp)
      end
    end

    def build_event row
      endtime = row['endtime']
      endtime = row['starttime'].to_datetime.end_of_day if row['allday'].to_s.downcase == "true"

      Event.new(title: row['title'],
        starttime: row['starttime'],
        endtime: endtime,
        description: row['description'],
        is_allday: row['allday']
      )
    end

  end
end
