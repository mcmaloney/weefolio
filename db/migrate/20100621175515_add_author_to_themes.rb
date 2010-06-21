class AddAuthorToThemes < ActiveRecord::Migration
  def self.up
    add_column :themes, :author_name, :string
  end

  def self.down
    remove_column :themes, :author_name
  end
end
