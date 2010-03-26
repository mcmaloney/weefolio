class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.integer :user_id
      t.integer :level

      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end
