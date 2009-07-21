class AddAttachmentsImage1ToPortfolio < ActiveRecord::Migration
  def self.up
    add_column :portfolios, :image_1_file_name, :string
    add_column :portfolios, :image_1_content_type, :string
    add_column :portfolios, :image_1_file_size, :integer
    add_column :portfolios, :image_1_updated_at, :datetime
  end

  def self.down
    remove_column :portfolios, :image_1_file_name
    remove_column :portfolios, :image_1_content_type
    remove_column :portfolios, :image_1_file_size
    remove_column :portfolios, :image_1_updated_at
  end
end
