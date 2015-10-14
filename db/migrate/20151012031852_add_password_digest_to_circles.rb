class AddPasswordDigestToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :password_digest, :string
  end
end
