class AddPositionToPieces < ActiveRecord::Migration
  def self.up
    add_column :pieces, :position, :integer
  end

  def self.down
    remove_column :pieces, :position
  end
end
