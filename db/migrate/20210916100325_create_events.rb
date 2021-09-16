class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starttime
      t.datetime :endtime
      t.text :description
      t.boolean :is_allday

      t.timestamps
    end
  end
end
