class CreatePieces < ActiveRecord::Migration
  def self.up
    create_table :pieces do |t|
      t.string :title
      t.string :description
      t.decimal :price, :precision => 10, :scale => 2
      t.boolean :for_sale
      t.integer :portfolio_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pieces
  end
end
