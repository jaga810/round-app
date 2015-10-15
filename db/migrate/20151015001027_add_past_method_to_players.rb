class AddPastMethodToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :past_method, :text
  end
end
