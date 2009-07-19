class AddAccountTierToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :account_tier, :integer, :default => 1
  end

  def self.down
    remove_column :users, :account_tier
  end
end
