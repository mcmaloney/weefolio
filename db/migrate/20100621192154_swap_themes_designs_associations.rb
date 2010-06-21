class SwapThemesDesignsAssociations < ActiveRecord::Migration
  def self.up
    remove_column :themes, :design_id
    add_column :designs, :theme_id, :integer
  end

  def self.down
    add_column :themes, :design_id, :integer
    remove_column :designs, :theme_id
  end
end
