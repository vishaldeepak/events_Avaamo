class AddIndexesToTables < ActiveRecord::Migration[6.1]
  def change
    add_index :user_events, :rsvp
    add_index :user_events, [:user_id, :event_id], unique: true
    add_index :events, :starttime
    add_index :events, :endtime
  end
end
