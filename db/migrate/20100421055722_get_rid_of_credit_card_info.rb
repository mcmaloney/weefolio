class GetRidOfCreditCardInfo < ActiveRecord::Migration
  def self.up
    remove_column :plans, :card_number
    remove_column :plans, :card_verification
  end

  def self.down
    add_column :plans, :card_number, :string
    add_column :plans, :card_verification, :string
  end
end
