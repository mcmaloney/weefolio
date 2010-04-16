class RedoDesigns < ActiveRecord::Migration
  def self.up
    create_table :designs do |t|
      t.integer :user_id
      t.integer :layout_type, :integer, :default => 1
      t.header_image_file_name :string
      t.header_image_content_type :string
      t.header_image_file_size :integer
      t.header_image_updated_at :datetime

      t.timestamps
    end
  end

  def self.down
    drop_table "designs"
  end
end
