class AddDesignTypeToUsersWithDefaultValue < ActiveRecord::Migration
  def self.up
    add_column :users, :design_type, :integer, :default => 1
  end

  def self.down
    remove_column :users, :design_type
  end
end
