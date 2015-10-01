class AddNowPlayersToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :now_players, :integer
  end
end
