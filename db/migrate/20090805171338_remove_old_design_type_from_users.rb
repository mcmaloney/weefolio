class RemoveOldDesignTypeFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :design_type
  end

  def self.down
    add_column :users, :design_type, :integer
  end
end
