class AddComToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :com, :boolean
  end
end
