class AddNameToThemes < ActiveRecord::Migration
  def self.up
    add_column :themes, :name, :string
  end

  def self.down
    remove_column :themes, :name
  end
end
