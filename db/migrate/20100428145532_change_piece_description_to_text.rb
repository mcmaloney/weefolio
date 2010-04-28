class ChangePieceDescriptionToText < ActiveRecord::Migration
  def self.up
    change_column :pieces, :description, :text
  end

  def self.down
    change_column :pieces, :description, :string
  end
end
