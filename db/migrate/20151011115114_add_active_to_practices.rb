class AddActiveToPractices < ActiveRecord::Migration
  def change
    add_column :practices, :active, :boolean, default: true
  end
end
