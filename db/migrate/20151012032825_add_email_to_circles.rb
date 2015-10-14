class AddEmailToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :email, :string
  end
end
