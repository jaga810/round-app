class AddMethodToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :method, :string
  end
end
