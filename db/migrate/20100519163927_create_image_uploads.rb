class CreateImageUploads < ActiveRecord::Migration
  def self.up
    create_table :image_uploads do |t|
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.integer  :piece_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :image_uploads
  end
end
