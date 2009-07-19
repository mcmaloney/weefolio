class AddInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :type, :integer, :default => 1
    add_column :users, :about_me, :text
    add_column :users, :tag_line, :string, :limit => 500
    add_column :users, :design_type, :integer
  end

  def self.down
    remove_column :users, :design_type
    remove_column :users, :tag_line
    remove_column :users, :about_me
    remove_column :users, :type
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
