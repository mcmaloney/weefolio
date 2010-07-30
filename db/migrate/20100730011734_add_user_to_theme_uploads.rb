class AddUserToThemeUploads < ActiveRecord::Migration
  def self.up
    add_column :theme_uploads, :user_id, :integer
  end

  def self.down
    remove_column :theme_uploads, :user_id
  end
end
