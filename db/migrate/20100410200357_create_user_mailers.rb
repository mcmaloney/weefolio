class CreateUserMailers < ActiveRecord::Migration
  def self.up
    create_table :user_mailers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :user_mailers
  end
end
