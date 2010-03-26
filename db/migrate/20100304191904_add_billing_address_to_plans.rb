class AddBillingAddressToPlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :billing_first_name, :string
    add_column :plans, :billing_last_name, :string
    add_column :plans, :billing_address, :string
    add_column :plans, :billing_address_2, :string
    add_column :plans, :billing_city, :string
    add_column :plans, :billing_state, :string
    add_column :plans, :billing_postal_code, :string
  end

  def self.down
    remove_column :plans, :billing_first_name
    remove_column :plans, :billing_last_name
    remove_column :plans, :billing_address
    remove_column :plans, :billing_address_2
    remove_column :plans, :billing_city
    remove_column :plans, :billing_state
    remove_column :plans, :billing_postal_code
  end
end
