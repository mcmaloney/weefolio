class AddLoginToPortfolios < ActiveRecord::Migration
  def self.up
    add_column :portfolios, :login, :string
  end

  def self.down
    remove_column :portfolios, :login
  end
end
