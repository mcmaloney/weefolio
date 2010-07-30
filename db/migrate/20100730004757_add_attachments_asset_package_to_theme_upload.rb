class AddAttachmentsAssetPackageToThemeUpload < ActiveRecord::Migration
  def self.up
    add_column :theme_uploads, :asset_package_file_name, :string
    add_column :theme_uploads, :asset_package_content_type, :string
    add_column :theme_uploads, :asset_package_file_size, :integer
    add_column :theme_uploads, :asset_package_updated_at, :datetime
  end

  def self.down
    remove_column :theme_uploads, :asset_package_file_name
    remove_column :theme_uploads, :asset_package_content_type
    remove_column :theme_uploads, :asset_package_file_size
    remove_column :theme_uploads, :asset_package_updated_at
  end
end
