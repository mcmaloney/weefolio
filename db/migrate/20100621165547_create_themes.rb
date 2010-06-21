class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :directory_name
      t.string :template_filename
      t.integer :design_id

      t.timestamps
    end
  end

  def self.down
    drop_table :themes
  end
end
