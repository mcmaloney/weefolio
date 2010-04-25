class AddDefaultTemplateToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :browser_html, :text
    add_column :designs, :user_html, :text
  end

  def self.down
    remove_column :designs, :browser_html
    remove_column :designs, :user_html
  end
end
