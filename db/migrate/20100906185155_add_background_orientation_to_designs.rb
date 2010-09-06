class AddBackgroundOrientationToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :background_orientation, :string
  end

  def self.down
    remove_column :designs, :background_orientation
  end
end
