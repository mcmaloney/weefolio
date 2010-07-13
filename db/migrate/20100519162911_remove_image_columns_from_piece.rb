class RemoveImageColumnsFromPiece < ActiveRecord::Migration
  def self.up
    remove_column :pieces, :image_1_file_name
    remove_column :pieces, :image_1_content_type
    remove_column :pieces, :image_1_file_size
    remove_column :pieces, :image_1_updated_at
    
    remove_column :pieces, :image_2_file_name
    remove_column :pieces, :image_2_content_type
    remove_column :pieces, :image_2_file_size
    remove_column :pieces, :image_2_updated_at
    
    remove_column :pieces, :image_3_file_name
    remove_column :pieces, :image_3_content_type
    remove_column :pieces, :image_3_file_size
    remove_column :pieces, :image_3_updated_at
    
    remove_column :pieces, :image_4_file_name
    remove_column :pieces, :image_4_content_type
    remove_column :pieces, :image_4_file_size
    remove_column :pieces, :image_4_updated_at
    
    remove_column :pieces, :image_5_file_name
    remove_column :pieces, :image_5_content_type
    remove_column :pieces, :image_5_file_size
    remove_column :pieces, :image_5_updated_at
  end

  def self.down
    add_column :pieces, :image_1_file_name, :string
    add_column :pieces, :image_1_content_type, :string
    add_column :pieces, :image_1_file_size, :integer
    add_column :pieces, :image_1_updated_at, :datetime
    
    add_column :pieces, :image_2_file_name, :string
    add_column :pieces, :image_2_content_type, :string
    add_column :pieces, :image_2_file_size, :integer
    add_column :pieces, :image_2_updated_at, :datetime
    
    add_column :pieces, :image_3_file_name, :string
    add_column :pieces, :image_3_content_type, :string
    add_column :pieces, :image_3_file_size, :integer
    add_column :pieces, :image_3_updated_at, :datetime
    
    add_column :pieces, :image_4_file_name, :string
    add_column :pieces, :image_4_content_type, :string
    add_column :pieces, :image_4_file_size, :integer
    add_column :pieces, :image_4_updated_at, :datetime
    
    add_column :pieces, :image_5_file_name, :string
    add_column :pieces, :image_5_content_type, :string
    add_column :pieces, :image_5_file_size, :integer
    add_column :pieces, :image_5_updated_at, :datetime
  end
end
