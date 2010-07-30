class CreateThemeUploads < ActiveRecord::Migration
  def self.up
    create_table :theme_uploads do |t|
      t.string :title
      t.text :source_code

      t.timestamps
    end
  end

  def self.down
    drop_table :theme_uploads
  end
end
