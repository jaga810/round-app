class AddForbiddenToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :forbidden, :text
  end
end
