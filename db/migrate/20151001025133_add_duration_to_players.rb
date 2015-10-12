class AddDurationToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :duration, :integer,default: 0
  end
end
