class AddCssTextToDesign < ActiveRecord::Migration
  def self.up
    add_column :designs, :css_text, :text
  end

  def self.down
    remove_column :designs, :css_text
  end
end
