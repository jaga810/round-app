class AddGroupToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :group, :string
  end
end
