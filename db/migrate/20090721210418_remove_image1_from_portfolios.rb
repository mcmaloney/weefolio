class RemoveImage1FromPortfolios < ActiveRecord::Migration
  def self.up
    remove_column :portfolios, :image_1_file_name
    remove_column :portfolios, :image_1_content_type
    remove_column :portfolios, :image_1_file_size
    remove_column :portfolios, :image_1_updated_at
  end

  def self.down
    add_column :portfolios, :image_1_file_name, :string
    add_column :portfolios, :image_1_content_type, :string
    add_column :portfolios, :image_1_file_size, :integer
    add_column :portfolios, :image_1_updated_at, :datetime
  end
end
