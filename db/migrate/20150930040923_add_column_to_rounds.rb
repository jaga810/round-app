class AddColumnToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :man_rane, :integer
    add_column :rounds, :mix_rane, :integer
  end
end
