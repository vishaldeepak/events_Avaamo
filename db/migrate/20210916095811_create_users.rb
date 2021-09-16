class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email, index: { unique: true }
      t.string :phone

      t.timestamps
    end
  end
end
