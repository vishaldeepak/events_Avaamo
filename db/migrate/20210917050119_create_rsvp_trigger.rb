class CreateRsvpTrigger < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION resolve_event_user_conflict() RETURNS trigger
      AS $$
      DECLARE event_starttime timestamp;
      DECLARE event_endtime timestamp;
      DECLARE event record;
      DECLARE identifier int ARRAY;
      BEGIN
        select starttime INTO event_starttime from events where id = NEW.event_id;
        select endtime INTO event_endtime from events where id = NEW.event_id;
        select array_agg(user_events.id) INTO identifier from user_events INNER JOIN EVENTS ON
          user_events.event_id = events.id
          WHERE user_events.rsvp = 2
          AND user_events.user_id = NEW.user_id
          AND (( events.starttime,  events.endtime) OVERLAPS ( event_starttime,  event_endtime));

        RAISE NOTICE 'value is % at %', event_starttime, event_endtime;
        RAISE NOTICE 'new is % at %', NEW.event_id, NEW.user_id;
        RAISE NOTICE 'new is %', identifier;

        IF identifier IS NOT NULL THEN
          Update user_events set rsvp = 1
            WHERE id = ANY(identifier);
        END IF;
        RETURN NEW;
      END;
      $$
      LANGUAGE plpgsql;

      CREATE TRIGGER resolve_event_user_conflict BEFORE INSERT OR UPDATE on "user_events" FOR EACH ROW WHEN (NEW.rsvp = 2) EXECUTE PROCEDURE resolve_event_user_conflict();
    SQL

  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS resolve_event_user_conflict on user_events;
    SQL
  end
end


