class AddColumnToPractices < ActiveRecord::Migration
  def change
    add_column :practices, :method, :string
    add_column :practices, :man_rane, :integer
    add_column :practices, :mix_rane, :integer
  end
end
