class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin_user, :boolean, :default => false
  end

  def self.down
    remove_column :users, :admin_user
  end
end
