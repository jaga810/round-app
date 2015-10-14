class AddRememberTokenToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :remember_token, :string
  end
end
