class RemoveAccountTierFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :account_tier
  end

  def self.down
    add_column :users, :account_tier, :integer
  end
end
