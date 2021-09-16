class CreateUserEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :user_events do |t|
      t.references :user, type: :string, null: false
      t.references :event, null: false, foreign_key: true
      t.integer :rsvp
      t.timestamps
    end

    add_foreign_key :user_events, :users, column: 'user_id', primary_key: 'username'
  end
end
