class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :practice_id

      t.timestamps null: false
    end
  end
end
