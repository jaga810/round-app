class AddColumnToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :time, :integer, default: 0
    add_column :players, :s_time, :integer, default: 0
    add_column :players, :v_time, :integer, default: 0
    add_column :players, :o_time, :integer, default: 0
  end
end
