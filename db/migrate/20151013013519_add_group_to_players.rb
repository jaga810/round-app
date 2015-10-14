class AddGroupToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :group, :string
  end
end
