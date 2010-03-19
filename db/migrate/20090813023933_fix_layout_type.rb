class FixLayoutType < ActiveRecord::Migration
  def self.up
    #remove_column :users, :layout_type
    add_column :designs, :layout_type, :integer, :default => 1
  end

  def self.down
    #add_column :users, :layout_type, :integer, :default => 1
    #remove_column :designs, :layout_type
  end
end
