class AddFemaleRaneToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :female_rane, :integer
  end
end
