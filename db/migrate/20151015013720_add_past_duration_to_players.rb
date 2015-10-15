class AddPastDurationToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :past_duration, :text
  end
end
