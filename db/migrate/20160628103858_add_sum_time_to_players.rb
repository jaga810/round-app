class AddSumTimeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :sum_time, :integer
  end
end
