class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :circle_id
      t.boolean :gender

      t.timestamps null: false
    end
  end
end
