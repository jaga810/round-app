class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.integer :circle_id

      t.timestamps null: false
    end
  end
end
