class AddFemaleRaneToPractice < ActiveRecord::Migration
  def change
    add_column :practices, :female_rane, :integer
  end
end
