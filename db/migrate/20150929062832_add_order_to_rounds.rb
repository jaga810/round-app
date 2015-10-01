class AddOrderToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :order, :integer, default: 1
  end
end
