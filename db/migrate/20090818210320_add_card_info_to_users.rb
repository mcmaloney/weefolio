class AddCardInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :card_number, :string
    add_column :users, :card_verification, :string
    add_column :users, :card_expiration_month, :string
    add_column :users, :card_expiration_year, :string
    add_column :users, :card_type, :string
  end

  def self.down
    remove_column :users, :card_number
    remove_column :users, :card_verification
    remove_column :users, :card_expiration_month
    remove_column :users, :card_expiration_year
    remove_column :users, :card_type
  end
end
