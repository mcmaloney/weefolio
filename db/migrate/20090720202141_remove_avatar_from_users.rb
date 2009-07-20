class RemoveAvatarFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :photo_file_size
    remove_column :users, :photo_content_type
    remove_column :users, :photo_file_name
  end

  def self.down
    add_column :users, :photo_file_name, :string
    add_column :users, :photo_content_type, :string
    add_column :users, :photo_file_size, :integer
  end
end
