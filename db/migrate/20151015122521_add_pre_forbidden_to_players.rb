class AddPreForbiddenToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :pre_forbidden, :string
  end
end
