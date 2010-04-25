class RedoDesigns < ActiveRecord::Migration
  def self.up
    create_table :designs do |t|
      t.integer :user_id
      t.integer :layout_type, :default => 1
      t.string :header_image_file_name
      t.string :header_image_content_type 
      t.integer :header_image_file_size
      t.datetime :header_image_updated_at
      t.string :background_color, :default => "f5f5f3"
      t.string :text_color, :default => "767574"
      t.string :title_color, :default => "242420"
      t.string :link_color, :default => "9fcf44"
      t.string :link_hover_color, :default => "242420"
      t.string :header_color, :default => "xxxxxx"
      t.string :font_family, :default => "Lucida Grande"
      t.integer :font_size, :default => 11
      t.string :header_color, :default => "242420"
      t.string :border_color, :default => "dcdcda"
      
      t.timestamps
    end
  end

  def self.down
    drop_table "designs"
  end
end
