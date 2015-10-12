class AddPlayedPlayerToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :played_player, :text, default: "nil"
  end
end
