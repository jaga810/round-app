class AddColumnToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :time, :integer
    add_column :players, :s_time, :integer
    add_column :players, :v_time, :integer
    add_column :players, :o_time, :integer
  end
end
