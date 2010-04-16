class AddNewDesignTemplate < ActiveRecord::Migration
  def self.up
    drop_table "designs" 
  end

  def self.down
    create_table :designs do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
